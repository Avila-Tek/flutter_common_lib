import 'package:avilatek_ui/avilatek_ui.dart';
import 'package:example/pages/file_uploader/file_uploader_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileUploaderPage extends StatelessWidget {
  const FileUploaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FileUploaderBloc(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Photo Picker'),
          ),
          body: const FileUploaderBody()),
    );
  }
}

class FileUploaderBody extends StatelessWidget {
  const FileUploaderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FileUploaderBloc, PickAndUploadFileState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state.isFailedToUploadFile) {
          AvilaSnackBar.failure(
            context: context,
            content: const Text('Failed to upload file'),
          ).show(context);
        }
        if (state.isUploadedFileSuccessfully) {
          AvilaSnackBar.success(
            context: context,
            content: const Text('File uploaded successfully'),
          ).show(context);
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              width: 250,
              child: Builder(
                builder: (context) {
                  if (state.isUploadingFirstFile) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.hasFileUploaded) {
                    return Stack(
                      children: [
                        Image.network(
                          (state as UploadedState).fileUrl,
                          loadingBuilder: (context, child, loadingProgress) {
                            return loadingProgress == null
                                ? child
                                : CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? (loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!)
                                        : null,
                                  );
                          },
                          fit: BoxFit.cover,
                        ),
                        if (state.isRepickingFile) const _RepickOverlayWidget(),
                        if (state.isReuploadingFile)
                          const _ReuploadOverlayWidget(),
                      ],
                    );
                  }

                  return const Center(child: Text('No file uploaded yet'));
                },
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<FileUploaderBloc>().add(const PickFile());
                },
                child: const Text('Pick a file to upload'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RepickOverlayWidget extends StatelessWidget {
  const _RepickOverlayWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Picking new file... ',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}

class _ReuploadOverlayWidget extends StatelessWidget {
  const _ReuploadOverlayWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.white.withOpacity(0.85),
              ),
              const SizedBox(height: 8),
              Text(
                'Uploading file...',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }
}
