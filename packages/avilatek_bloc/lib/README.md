# avilatek_bloc

A collection of useful blocs for Flutter applications, made with 💚 by Avila Tek.



## RemoteDataBloc

### Introduction

This bloc is a generalized state machine for handling remote data. It abstracts the process of fetching data from the internet and provides a simple and consistent interface for handling the various states of the data fetching process.

The `RemoteDataBloc` State Machine is as follows:

```mermaid

---
title: RemoteDataBloc State Machine
---

    graph LR;
        
        subgraph RemoteDataUninitialized
            D -.-> A;
            B -- "error" --> D[RemoteDataInitialFetchingFailure];
            A[RemoteDataUninitialized] -- FetchData --> B[RemoteDataInitialFetching];
        end
        subgraph RemoteDataInitialized
            B -. "success" ..-> E[RemoteDataFetched];
            E -- FetchData --> F[RemoteDataRefetching];
            F -- "error" --> G[RemoteDataRefetchingFailure];
            F -- "success" --> H[RemoteDataRefetchingSuccess];
            G & H -.-> E;
        end
    linkStyle 0,1,5,7 stroke:#f05,stroke-width:2px,color:crimson;
        linkStyle 3,6,8 stroke:lightgreen,stroke-width:2px,color:lightgreen;
```

## PagedRemoteDataBloc

### Introduction

This bloc is similar to `RemoteDataBloc`, but it is specialized for handling paged data. It abstracts the process of fetching paged data from the internet and provides a simple and consistent interface for handling the various states of the paginated data fetching process.

The `PagedRemoteDataBloc` State Machine is as follows:

```mermaid
---
title: PagedRemoteDataBloc State Machine
---

    graph TB;
        
        subgraph PagedRemoteDataUninitialized
            D -.-> A;
            B -- "error" --> D[PagedRemoteDataFirstPageFetchingFailure];
            A[PagedRemoteDataUninitialized] -- FetchData --> B[PagedRemoteDataFirstPageFetching];
        end
        subgraph PagedRemoteDataInitialized
            B -. "success" ..-> E[PagedRemoteDataNextPageFetched];
            E -- FetchData --> F[PagedRemoteDataNextPageFetching];
            F -- "error" --> G[PagedRemoteDataNextPageFetchingFailure];
            F -- "success" --> H[PagedRemoteDataNextPageFetchingSuccess];
            H -..-> I[PagedRemoteDataLastPageFetched];
            G -...-> E;
            H -.-> E;
        end
        linkStyle 0,1,5,8 stroke:#f05,stroke-width:2px,color:crimson;
        linkStyle 3,6,7,9 stroke:lightgreen,stroke-width:2px,color:lightgreen;
```


## PickAndUploadFileBloc

### Introduction

This bloc defines a useful and generalized state machine for picking and uploading files to the internet. It abstracts the process of picking a file from any source and uploading it to a target location. 

The `PickAndUploadFileBloc` State Machine is as follows:

```mermaid

---
title: PickAndUploadFileBloc State Machine
---

    graph LR;
        
        subgraph UnuploadedState
            D -.-> A;
            B -- "error" --> D[PickFailure];
            B -- "success" --> E[UploadingFile];
            E -- "success" --> F[UploadSuccess];
            E -- "error" --> G[UploadFailure];
            A[FileUnpicked] -- Event PickFile --> B[PickingFile];
        end
        subgraph UploadedState
            G -.-> A;
            F -.-> H[FileUploaded];
            H -- Event PickFile ---> I[RepickingFile];
            I -- "error" ---> J[RepickingFileFailure];
            I -- "success" --> K[ReuploadingFile];
            K -- "success" ---> L[ReuploadSuccess];
            K -- "error" ---> M[ReuploadFailure];
            J & L & M -.-> H;
        end
        linkStyle 1,0,4,6,9,12,13,15 stroke:#f05,stroke-width:2px,color:crimson;
        linkStyle 2,3,7,10,11,14 stroke:lightgreen,stroke-width:2px,color:lightgreen;
```
