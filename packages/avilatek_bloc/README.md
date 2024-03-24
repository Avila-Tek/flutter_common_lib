# Avilatek Bloc

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]


A collection of useful blocs for Flutter applications, made with 💚 by Avila Tek.


## Installation 💻

**❗ In order to start using Avilatek Bloc you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Add `avilatek_bloc` to your `pubspec.yaml`:

```yaml
dependencies:
  avilatek_bloc:
```

Install it:

```sh
flutter packages get
```

## RemoteDataBloc


This bloc is a generalized state machine for handling data fetching. It abstracts the process of fetching data from the internet and provides a simple and consistent interface for handling the various states of the data fetching process.

It is useful for handling the process of fetching data from the internet, such as fetching a single item, a list of items, a file, etc. One of the advantages of this bloc, apart from its simplicity, is that it makes it possible to keep data in the UI while refetching, or to show the last fetched data in case of an error in a simple way.


Note: If you need to paginate the data, you may use the [`PagedRemoteDataBloc`](#PagedRemoteDataBloc) instead.

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
## SendDataBloc

This bloc is a generalized state machine to send data. It abstracts the process of sending payloads to a remote server and provides a simple and consistent interface for handling the various states of this process.

This bloc is useful for handling the process of sending data to a remote server, such as sending a form, sending a message, or sending a file. It does not care about storing any reference to the data being sent, it only cares about the process of sending the data. If you need to store the data before, during or after being sent, you may combine this with anouther bloc that stores it.


The `SendDataBloc` State Machine is as follows:

```mermaid

---
title: SendDataBloc State Machine
---

    graph LR;
        A[SendDataReady] -- DataSent --> B[SendDataLoading];
        D -.-> A;
        B -- "error" --> D[SendDataFailure];
        B -- "success" --> E[SendDataSuccess];
        E -.-> A
    linkStyle 1,2 stroke:#f05,stroke-width:2px,color:crimson;
        linkStyle 3,4 stroke:lightgreen,stroke-width:2px,color:lightgreen;
```
<a id="PagedRemoteDataBloc"></a>
## PagedRemoteDataBloc


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


[flutter_install_link]: https://docs.flutter.dev/get-started/install
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://pub.dev/packages/very_good_cli
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
