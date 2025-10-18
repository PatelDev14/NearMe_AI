// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';

// class ResultCard extends StatefulWidget {
//   final dynamic item;
//   final bool isUser;
  
//   const ResultCard({
//     super.key,
//     required this.item,
//     this.isUser = false,
//   });

//   @override
//   State<ResultCard> createState() => _ResultCardState();
// }

// class _ResultCardState extends State<ResultCard> {
//   bool _isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     final name = widget.item['name'] ?? '';
//     final category = widget.item['category'] ?? '';
//     final markdown = widget.item['markdown'] ?? widget.item['summary'] ?? 'No content';
//     final distance = widget.item['distance']; // e.g., "0.5 km"
//     final rating = widget.item['rating']; // e.g., 4.5
//     final imageUrl = widget.item['image'];
    
//     // User messages - keep simple
//     if (widget.isUser) {
//       return Padding(
//         padding: const EdgeInsets.only(left: 60, right: 16, top: 8, bottom: 8),
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               markdown,
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Theme.of(context).colorScheme.onSurface,
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     // Bot responses - rich content
//     return Padding(
//       padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Category tag (if present)
//           if (category.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           _getCategoryIcon(category),
//                           size: 14,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                         const SizedBox(width: 6),
//                         Text(
//                           category.toUpperCase(),
//                           style: TextStyle(
//                             color: Theme.of(context).colorScheme.primary,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 11,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//           // Image (if present)
//           if (imageUrl != null)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.network(
//                   imageUrl,
//                   height: 200,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     height: 200,
//                     color: Colors.grey.shade200,
//                     child: const Icon(Icons.image_not_supported, size: 50),
//                   ),
//                 ),
//               ),
//             ),

//           // Title and metadata row
//           if (name.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       height: 1.2,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       if (rating != null) ...[
//                         Icon(Icons.star, size: 16, color: Colors.amber.shade700),
//                         const SizedBox(width: 4),
//                         Text(
//                           rating.toString(),
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.grey.shade700,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                       ],
//                       if (distance != null) ...[
//                         Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
//                         const SizedBox(width: 4),
//                         Text(
//                           distance,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey.shade700,
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//           // Main content
//           MarkdownBody(
//             data: _isExpanded ? markdown : _truncateText(markdown, 200),
//             styleSheet: MarkdownStyleSheet(
//               p: TextStyle(
//                 fontSize: 15,
//                 height: 1.6,
//                 color: Colors.grey.shade800,
//               ),
//               h1: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               h2: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               h3: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               listBullet: TextStyle(color: Theme.of(context).colorScheme.primary),
//               blockSpacing: 10,
//             ),
//           ),

//           // Show more/less button
//           if (markdown.length > 200)
//             GestureDetector(
//               onTap: () => setState(() => _isExpanded = !_isExpanded),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 8),
//                 child: Text(
//                   _isExpanded ? 'Show less' : 'Show more',
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.primary,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ),

//           // Action buttons
//           Padding(
//             padding: const EdgeInsets.only(top: 16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     onPressed: () {
//                       // Handle "Interested" action
//                     },
//                     icon: const Icon(Icons.thumb_up_outlined, size: 18),
//                     label: const Text('Interested'),
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: FilledButton.icon(
//                     onPressed: () {
//                       // Handle "Take me there" action
//                     },
//                     icon: const Icon(Icons.navigation, size: 18),
//                     label: const Text('Navigate'),
//                     style: FilledButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Divider between results
//           Padding(
//             padding: const EdgeInsets.only(top: 24),
//             child: Divider(color: Colors.grey.shade200, height: 1),
//           ),
//         ],
//       ),
//     );
//   }

//   String _truncateText(String text, int maxLength) {
//     if (text.length <= maxLength) return text;
//     return '${text.substring(0, maxLength)}...';
//   }

//   IconData _getCategoryIcon(String category) {
//     final cat = category.toLowerCase();
//     if (cat.contains('food') || cat.contains('restaurant')) return Icons.restaurant;
//     if (cat.contains('coffee') || cat.contains('cafe')) return Icons.coffee;
//     if (cat.contains('shop')) return Icons.shopping_bag;
//     if (cat.contains('activity')) return Icons.local_activity;
//     if (cat.contains('park')) return Icons.park;
//     return Icons.place;
//   }
// }

// import 'package:flutter/material.dart';

// class ResultCard extends StatelessWidget {
//   final dynamic item;
//   final bool isUser;
  
//   const ResultCard({
//     super.key,
//     required this.item,
//     this.isUser = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final name = item['name'] ?? '';
//     final category = item['category'] ?? '';
//     final content = item['markdown'] ?? item['summary'] ?? 'No content';
//     final distance = item['distance'];
//     final rating = item['rating'];
    
//     // User messages
//     if (isUser) {
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(80, 8, 24, 8),
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               content,
//               style: const TextStyle(
//                 fontSize: 15,
//                 height: 1.5,
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     // Bot responses - like Claude's text style
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Category (subtle, like a header)
//           if (category.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: Text(
//                 category.toUpperCase(),
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 1.2,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//             ),

//           // Title (like a section heading)
//           if (name.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: Text(
//                 name,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   height: 1.3,
//                   letterSpacing: -0.3,
//                 ),
//               ),
//             ),

//           // Rating and distance (inline, natural)
//           if (rating != null || distance != null)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: Text(
//                 [
//                   if (rating != null) '⭐ $rating',
//                   if (distance != null) '📍 $distance away',
//                 ].join('  •  '),
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey.shade700,
//                   height: 1.5,
//                 ),
//               ),
//             ),

//           // Main content - just like regular text
//           SelectableText(
//             content,
//             style: const TextStyle(
//               fontSize: 16,
//               height: 1.7,
//               letterSpacing: 0.1,
//             ),
//           ),

//           // Action buttons (clean and simple)
//           if (name.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 24),
//               child: Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: [
//                   _buildActionChip(
//                     context,
//                     label: 'Save for later',
//                     icon: Icons.bookmark_outline,
//                     onTap: () {},
//                   ),
//                   _buildActionChip(
//                     context,
//                     label: 'Get directions',
//                     icon: Icons.directions_outlined,
//                     filled: true,
//                     onTap: () {},
//                   ),
//                   _buildActionChip(
//                     context,
//                     label: 'Not interested',
//                     icon: Icons.close,
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionChip(
//     BuildContext context, {
//     required String label,
//     required IconData icon,
//     bool filled = false,
//     required VoidCallback onTap,
//   }) {
//     return Material(
//       color: filled 
//           ? Theme.of(context).colorScheme.primary 
//           : Colors.transparent,
//       borderRadius: BorderRadius.circular(20),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             border: filled 
//                 ? null 
//                 : Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 icon,
//                 size: 18,
//                 color: filled ? Colors.white : Colors.grey.shade700,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: filled ? Colors.white : Colors.grey.shade800,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultCard extends StatelessWidget {
  final dynamic item;
  final bool isUser;

  const ResultCard({
    super.key,
    required this.item,
    this.isUser = false,
  });

  @override
  Widget build(BuildContext context) {
    final name = item['name'] ?? '';
    final description = item['description'] ?? item['summary'] ?? 'No description';
    final rating = item['rating'];
    final distance = item['distance'];
    final website = item['website'];
    final mapsLink = item['maps_link'];
    final reviewsLink = item['reviews_link'];

    // 🎯 USER MESSAGE BUBBLE
    if (isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.fromLTRB(80, 8, 20, 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ),
      );
    }

    // 🤖 AI RESPONSE CARD
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Subtle decorative gradient background
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.blue.shade50.withOpacity(0.3),
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🏷 TITLE
                  if (name.isNotEmpty)
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                        color: Colors.black87,
                      ),
                    ),

                  // ⭐ RATING + DISTANCE
                  if (rating != null || distance != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          if (rating != null)
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          if (rating != null && distance != null)
                            const SizedBox(width: 12),
                          if (distance != null)
                            Text(
                              '📍 $distance away',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                        ],
                      ),
                    ),

                  // 📝 DESCRIPTION
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 15.5,
                        height: 1.6,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),
                  const Divider(height: 1),

                  // 🔗 ACTION BUTTONS
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        if (website != null && website.toString().isNotEmpty)
                          _buildActionButton(
                            context,
                            icon: Icons.language_rounded,
                            label: "Website",
                            color: Colors.blueAccent,
                            onTap: () => _launch(website),
                          ),
                        if (mapsLink != null && mapsLink.toString().isNotEmpty)
                          _buildActionButton(
                            context,
                            icon: Icons.map_rounded,
                            label: "Directions",
                            color: Colors.green,
                            onTap: () => _launch(mapsLink),
                          ),
                        if (reviewsLink != null && reviewsLink.toString().isNotEmpty)
                          _buildActionButton(
                            context,
                            icon: Icons.reviews_rounded,
                            label: "Reviews",
                            color: Colors.orange,
                            onTap: () => _launch(reviewsLink),
                          ),
                        _buildActionButton(
                          context,
                          icon: Icons.favorite_border_rounded,
                          label: "Save",
                          color: Colors.pinkAccent,
                          onTap: () {},
                        ),
                      ],
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

  // 🌟 Helper for launching URLs safely
  Future<void> _launch(String url) async {
    final uri = Uri.tryParse(url);
    
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Color _textColorFor(Color color) {
    if (color == Colors.blueAccent) return Colors.blue.shade700;
    if (color == Colors.green) return Colors.green.shade700;
    if (color == Colors.orange) return Colors.orange.shade700;
    if (color == Colors.pinkAccent) return Colors.pink.shade700;
    return Colors.black87;
  }

  // 🧩 Action button design
  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: _textColorFor(color),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
