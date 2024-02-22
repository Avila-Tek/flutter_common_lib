<!-- Embed ./sample.svg here -->

# UploadFileBloc

## Introduction

This bloc defines a state machine for file picking and uploading. It abstracts the process of picking a file from any source and uploading it to a target location, usually a remote server. 

The `UploadFileBloc` State Machine is as follows:

```mermaid

---
title: UploadFileBloc State Machine
---

    graph LR;
        
        subgraph Not uploaded file state
            D -.-> A;
            B -- "error" --> D[PickFailure];
            B -- "success" --> E[UploadingFile];
            E -- "success" --> F[UploadSuccess];
            E -- "error" --> G[UploadFailure];
            A[PickInitial] -- [Event] PickFile --> B[PickingFile];
        end
        subgraph Uploaded file state
            subgraph FileUploadedState
            G -.-> A;
            F -.-> H[FileUploaded];
            H -- [Event] PickFile ---> I[RepickingFile];
            I -- "error" ---> J[RepickingFileFailure];
            I -- "success" --> K[ReuploadingFile];
            K -- "success" ---> L[ReuploadSuccess];
            K -- "error" ---> M[ReuploadFailure];
            J & L & M -.-> H;
            end
        end
        
```


## Usage

The `UploadFileBloc` is a generic bloc that requires a `File` type. It is used as follows:
