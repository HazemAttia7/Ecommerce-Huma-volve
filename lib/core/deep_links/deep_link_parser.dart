import 'package:ecommerce_app_huma_volve/core/constants/deep_link_constants.dart';

/// Parses incoming URIs and extracts product ids.
///
/// Valid format: `ecommerceapp://product/{id}` where `{id}` is a positive integer.
/// Returns null for anything that doesn't match.
class DeepLinkParser {
  const DeepLinkParser._();

  static int? parseProductId(Uri? uri) {
    if (uri == null) return null;
    if (uri.scheme != DeepLinkConstants.scheme) return null;
    if (uri.host != DeepLinkConstants.host) return null;

    // Path segments for "ecommerceapp://product/5" → ['5']
    final segments = uri.pathSegments;
    if (segments.isEmpty) return null;

    return int.tryParse(segments.first);
  }
}
