import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';

class PDFViewerScreen extends StatefulWidget {
  final String? pdfPath;
  final String? pdfUrl;
  final String title;

  const PDFViewerScreen({
    Key? key,
    this.pdfPath,
    this.pdfUrl,
    this.title = 'PDF Viewer',
  }) : super(key: key);

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? localPath;
  bool isLoading = true;
  String? errorMessage;
  int currentPage = 0;
  int totalPages = 0;
  PDFViewController? pdfController;

  @override
  void initState() {
    super.initState();
    _initializePDF();
  }

  Future<void> _initializePDF() async {
    try {
      if (widget.pdfPath != null) {
        // Use local file path
        localPath = widget.pdfPath;
      } else if (widget.pdfUrl != null) {
        // Download PDF from URL
        localPath = await _downloadPDF(widget.pdfUrl!);
      } else {
        throw Exception('No PDF path or URL provided');
      }
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = 'Error loading PDF: ${e.toString()}';
      });
    }
  }

  Future<String> _downloadPDF(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/${DateTime.now().millisecondsSinceEpoch}.pdf');
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      } else {
        throw Exception('Failed to download PDF: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error downloading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          if (!isLoading && localPath != null) ...[
            IconButton(
              icon: const Icon(Icons.zoom_in),
              onPressed: () => _zoomIn(),
            ),
            IconButton(
              icon: const Icon(Icons.zoom_out),
              onPressed: () => _zoomOut(),
            ),
          ],
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading PDF...'),
          ],
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  errorMessage = null;
                });
                _initializePDF();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (localPath == null) {
      return const Center(
        child: Text('No PDF file available'),
      );
    }

    return PDFView(
      filePath: localPath!,
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: false,
      pageFling: false,
      onRender: (pages) {
        setState(() {
          totalPages = pages ?? 0;
        });
      },
      onViewCreated: (PDFViewController pdfViewController) {
        pdfController = pdfViewController;
      },
      onPageChanged: (int? page, int? total) {
        setState(() {
          currentPage = page ?? 0;
          totalPages = total ?? 0;
        });
      },
      onError: (error) {
        setState(() {
          errorMessage = 'Error displaying PDF: $error';
        });
      },
    );
  }

  Widget? _buildBottomBar() {
    if (isLoading || localPath == null || totalPages == 0) {
      return null;
    }

    return Container(
      height: 60,
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: currentPage > 0 ? () => _goToPage(0) : null,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: currentPage > 0 ? () => _previousPage() : null,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '${currentPage + 1} / $totalPages',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: currentPage < totalPages - 1 ? () => _nextPage() : null,
          ),
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: currentPage < totalPages - 1
                ? () => _goToPage(totalPages - 1)
                : null,
          ),
        ],
      ),
    );
  }

  void _previousPage() {
    if (currentPage > 0) {
      pdfController?.setPage(currentPage - 1);
    }
  }

  void _nextPage() {
    if (currentPage < totalPages - 1) {
      pdfController?.setPage(currentPage + 1);
    }
  }

  void _goToPage(int page) {
    pdfController?.setPage(page);
  }

  void _zoomIn() {
    // Note: flutter_pdfview doesn't have built-in zoom methods
    // You might need to implement custom zoom functionality
    // or use a different package like syncfusion_flutter_pdfviewer
  }

  void _zoomOut() {
    // Note: flutter_pdfview doesn't have built-in zoom methods
    // You might need to implement custom zoom functionality
    // or use a different package like syncfusion_flutter_pdfviewer
  }
}

// Example usage widget
class PDFViewerExample extends StatelessWidget {
  const PDFViewerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Examples'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const PDFViewerScreen(
            //           pdfUrl:
            //               'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
            //           title: 'Sample PDF from URL',
            //         ),
            //       ),
            //     );
            //   },
            //   child: const Text('View PDF from URL'),
            // ),
            const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     // Replace with actual local file path
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const PDFViewerScreen(
            //           pdfPath: 'C:/Users/hp/Downloads/loc.pdf',
            //           title: 'Local PDF File',
            //         ),
            //       ),
            //     );
            //   },
            //   child: const Text('View Local PDF File'),
            // ),
          ],
        ),
      ),
    );
  }
}
