<!-- Embed ./sample.svg here -->

# UploadFileBloc

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
            G -.-> A;
            F -.-> H[UploadedFile];
            H -- [Event] PickFile ---> I[ReuploadingFile];
            I -- "success" ---> J[ReuploadSuccess];
            I -- "error" ---> K[ReuploadFailure];
            J & K -.-> H;
        end
        linkStyle 1,0,4,5,6,10,11,12 stroke:#f05,stroke-width:2px;
        linkStyle 2,3,7,9,11 stroke:lightgreen,stroke-width:2px;
```
