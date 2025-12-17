import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:taxi_client_app/app/config/dynamic_colors.dart';
import 'package:taxi_client_app/app/config/app_config_service.dart';
import 'package:taxi_client_app/models/vendor_model.dart';
import 'package:taxi_client_app/models/review_model.dart';
import 'package:taxi_client_app/services/tuwatech_store_service.dart';

@RoutePage()
class VendorDetailsView extends StatefulWidget {
  final String handle;

  const VendorDetailsView({super.key, @PathParam('handle') required this.handle});

  @override
  State<VendorDetailsView> createState() => _VendorDetailsViewState();
}

class _VendorDetailsViewState extends State<VendorDetailsView> {
  late DynamicColors _colors;
  late String _fontFamily;

  VendorModel? _vendor;
  List<ReviewModel> _reviews = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadConfig();
    _fetchVendorDetails();
  }

  void _loadConfig() {
    _colors = DynamicColors.instance;
    _fontFamily = AppConfigService.instance.fontFamily;
  }

  Future<void> _fetchVendorDetails() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      tuwaTechStoreService.init();

      // Fetch vendor details and reviews in parallel
      final results = await Future.wait([
        tuwaTechStoreService.getVendorByHandle(widget.handle),
        tuwaTechStoreService.getVendorReviews(widget.handle, limit: 10),
      ]);

      setState(() {
        _vendor = results[0] as VendorModel;
        _reviews = (results[1] as ReviewsResponse).reviews;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load vendor details: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: _colors.background, body: _buildBody());
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(color: _colors.primary));
    }

    if (_error != null || _vendor == null) {
      return SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: _colors.error),
              const SizedBox(height: 16),
              Text(
                'Something went wrong',
                style: TextStyle(
                  fontFamily: _fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _colors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _error ?? 'Vendor not found',
                style: TextStyle(fontFamily: _fontFamily, fontSize: 14, color: _colors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => context.router.pop(),
                    child: Text('Go Back', style: TextStyle(color: _colors.textSecondary)),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _fetchVendorDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _colors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        SliverToBoxAdapter(child: _buildVendorInfo()),
        SliverToBoxAdapter(child: _buildStatsSection()),
        if (_vendor!.specialties.isNotEmpty) SliverToBoxAdapter(child: _buildSpecialtiesSection()),
        SliverToBoxAdapter(child: _buildContactSection()),
        SliverToBoxAdapter(child: _buildReviewsHeader()),
        if (_reviews.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildReviewCard(_reviews[index]),
              childCount: _reviews.length,
            ),
          )
        else
          SliverToBoxAdapter(child: _buildNoReviews()),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: _colors.primary,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), shape: BoxShape.circle),
          child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
        ),
        onPressed: () => context.router.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_colors.primary, _colors.primary.withOpacity(0.8)],
                ),
              ),
            ),
            // Decorative circles
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
              ),
            ),
            Positioned(
              left: -30,
              bottom: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
              ),
            ),
            // Vendor logo
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _vendor!.logo != null
                        ? CachedNetworkImage(
                            imageUrl: _vendor!.logo!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.white,
                              child: Icon(Icons.store, color: _colors.primary, size: 40),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.white,
                              child: Icon(Icons.store, color: _colors.primary, size: 40),
                            ),
                          )
                        : Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(Icons.store, color: _colors.primary, size: 40),
                          ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _vendor!.name,
                    style: TextStyle(
                      fontFamily: _fontFamily,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVendorInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _colors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, size: 20, color: _colors.warning),
                    const SizedBox(width: 8),
                    Text(
                      _vendor!.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontFamily: _fontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: _colors.textPrimary,
                      ),
                    ),
                    Text(
                      ' (${_vendor!.totalReviews} reviews)',
                      style: TextStyle(fontFamily: _fontFamily, fontSize: 14, color: _colors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Description
          if (_vendor!.description != null) ...[
            Text(
              _vendor!.description!,
              style: TextStyle(
                fontFamily: _fontFamily,
                fontSize: 14,
                color: _colors.textSecondary,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: _colors.shadow.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(Icons.star, '${_vendor!.rating}', 'Rating'),
          _buildStatDivider(),
          _buildStatItem(Icons.reviews, '${_vendor!.totalReviews}', 'Reviews'),
          if (_vendor!.foundedYear != null) ...[
            _buildStatDivider(),
            _buildStatItem(Icons.calendar_today, '${_vendor!.foundedYear}', 'Founded'),
          ],
          if (_vendor!.employeeCount != null) ...[
            _buildStatDivider(),
            _buildStatItem(Icons.people, _vendor!.employeeCount!, 'Team'),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 24, color: _colors.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontFamily: _fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _colors.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontFamily: _fontFamily, fontSize: 12, color: _colors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(height: 40, width: 1, color: _colors.border);
  }

  Widget _buildSpecialtiesSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Specialties',
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _vendor!.specialties.map((specialty) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: _colors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  specialty,
                  style: TextStyle(
                    fontFamily: _fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _colors.primary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: _colors.shadow.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _colors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          if (_vendor!.email != null) _buildContactItem(Icons.email, _vendor!.email!),
          if (_vendor!.phone != null) _buildContactItem(Icons.phone, _vendor!.phone!),
          if (_vendor!.address != null) _buildContactItem(Icons.location_on, _vendor!.address!),
          if (_vendor!.city != null || _vendor!.country != null)
            _buildContactItem(
              Icons.public,
              [_vendor!.city, _vendor!.country].where((e) => e != null).join(', '),
            ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: _colors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontFamily: _fontFamily, fontSize: 14, color: _colors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent Reviews',
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _colors.textPrimary,
            ),
          ),
          if (_reviews.isNotEmpty)
            Text(
              '${_reviews.length} reviews',
              style: TextStyle(fontFamily: _fontFamily, fontSize: 13, color: _colors.textSecondary),
            ),
        ],
      ),
    );
  }

  Widget _buildNoReviews() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: _colors.surface, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Icon(Icons.rate_review_outlined, size: 48, color: _colors.textDisabled),
          const SizedBox(height: 12),
          Text(
            'No reviews yet',
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _colors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Be the first to review this vendor',
            style: TextStyle(fontFamily: _fontFamily, fontSize: 14, color: _colors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(ReviewModel review) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _colors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: _colors.shadow.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.rating ? Icons.star : Icons.star_border,
                    size: 18,
                    color: _colors.warning,
                  );
                }),
              ),
              if (review.isVerified)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _colors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.verified, size: 14, color: _colors.success),
                      const SizedBox(width: 4),
                      Text(
                        'Verified',
                        style: TextStyle(
                          fontFamily: _fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: _colors.success,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (review.title != null) ...[
            const SizedBox(height: 12),
            Text(
              review.title!,
              style: TextStyle(
                fontFamily: _fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _colors.textPrimary,
              ),
            ),
          ],
          if (review.content != null) ...[
            const SizedBox(height: 8),
            Text(
              review.content!,
              style: TextStyle(
                fontFamily: _fontFamily,
                fontSize: 14,
                color: _colors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            _formatDate(review.createdAt),
            style: TextStyle(fontFamily: _fontFamily, fontSize: 12, color: _colors.textDisabled),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
