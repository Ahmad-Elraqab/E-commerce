import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:taxi_client_app/app/config/dynamic_colors.dart';
import 'package:taxi_client_app/app/config/app_config_service.dart';
import 'package:taxi_client_app/app/router/router.gr.dart';
import 'package:taxi_client_app/core/di/injection_container.dart';
import 'package:taxi_client_app/domain/entities/vendor.dart';
import 'package:taxi_client_app/presentation/view_models/vendors_view_model.dart';

@RoutePage()
class VendorsView extends StatefulWidget {
  const VendorsView({super.key});

  @override
  State<VendorsView> createState() => _VendorsViewState();
}

class _VendorsViewState extends State<VendorsView> {
  late DynamicColors _colors;
  late String _fontFamily;
  late VendorsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _loadConfig();
    _viewModel = sl<VendorsViewModel>();
    _viewModel.fetchVendors(limit: 50);
  }

  void _loadConfig() {
    _colors = DynamicColors.instance;
    _fontFamily = AppConfigService.instance.fontFamily;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        backgroundColor: _colors.background,
        appBar: AppBar(
          backgroundColor: _colors.background,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: _colors.textPrimary),
            onPressed: () => context.router.pop(),
          ),
          title: Text(
            'All Vendors',
            style: TextStyle(
              fontFamily: _fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _colors.textPrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: Consumer<VendorsViewModel>(builder: (context, viewModel, child) => _buildBody(viewModel)),
      ),
    );
  }

  Widget _buildBody(VendorsViewModel viewModel) {
    if (viewModel.state == ViewState.loading) {
      return Center(child: CircularProgressIndicator(color: _colors.primary));
    }

    if (viewModel.state == ViewState.error) {
      return Center(
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
              viewModel.errorMessage ?? 'Unknown error',
              style: TextStyle(fontFamily: _fontFamily, fontSize: 14, color: _colors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => viewModel.fetchVendors(refresh: true),
              style: ElevatedButton.styleFrom(
                backgroundColor: _colors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (viewModel.vendors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.store_outlined, size: 64, color: _colors.textDisabled),
            const SizedBox(height: 16),
            Text(
              'No vendors found',
              style: TextStyle(
                fontFamily: _fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _colors.textPrimary,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.fetchVendors(refresh: true),
      color: _colors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: viewModel.vendors.length,
        itemBuilder: (context, index) => _buildVendorCard(viewModel.vendors[index]),
      ),
    );
  }

  Widget _buildVendorCard(Vendor vendor) {
    return GestureDetector(
      onTap: () => context.router.push(VendorDetailsView(handle: vendor.handle)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: vendor.logo != null
                        ? CachedNetworkImage(
                            imageUrl: vendor.logo!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 60,
                              height: 60,
                              color: _colors.primary.withOpacity(0.1),
                              child: Icon(Icons.store, color: _colors.primary),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 60,
                              height: 60,
                              color: _colors.primary.withOpacity(0.1),
                              child: Icon(Icons.store, color: _colors.primary),
                            ),
                          )
                        : Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: _colors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.store, color: _colors.primary, size: 28),
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vendor.name,
                          style: TextStyle(
                            fontFamily: _fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: _colors.warning),
                            const SizedBox(width: 4),
                            Text(
                              vendor.rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontFamily: _fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _colors.textPrimary,
                              ),
                            ),
                            Text(
                              ' (${vendor.totalReviews} reviews)',
                              style: TextStyle(
                                fontFamily: _fontFamily,
                                fontSize: 12,
                                color: _colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        if (vendor.city != null || vendor.country != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                Icon(Icons.location_on, size: 14, color: _colors.textSecondary),
                                const SizedBox(width: 4),
                                Text(
                                  [vendor.city, vendor.country].where((e) => e != null).join(', '),
                                  style: TextStyle(
                                    fontFamily: _fontFamily,
                                    fontSize: 12,
                                    color: _colors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: _colors.textDisabled),
                ],
              ),
            ),
            if (vendor.description != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(
                  vendor.description!,
                  style: TextStyle(
                    fontFamily: _fontFamily,
                    fontSize: 13,
                    color: _colors.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (vendor.specialties.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: vendor.specialties.take(3).map((specialty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _colors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        specialty,
                        style: TextStyle(
                          fontFamily: _fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: _colors.primary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
