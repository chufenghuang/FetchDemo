# FetchDemo App

The FetchDemo app is a SwiftUI application that retrieves and displays a list of items fetched from a remote JSON source.

## Main View

The main view of the application is structured using SwiftUI's declarative syntax. It comprises a `List` view that displays individual items grouped by their `listId`. Each item is presented using a custom `ItemCell` view, which formats the display of item properties in a more visual friendly way.

## Data Flow

Data within the application flows from the `JsonDataHandler`, which is responsible for both fetching the JSON from a remote URL and decoding it into an array of `Item` objects.

### Fetching JSON

The `JsonDataHandler` contains a function called `fetchJSONData(from:completion:)`. This function takes a URL string as input and uses a `URLSession` data task to fetch data asynchronously. Upon completion, it returns a result that contains either the fetched JSON string or an error.

### Decoding JSON

Once the JSON is fetched, `decodeItems(from:)` within the `JsonDataHandler` decodes the JSON string into an array of `Item` objects using Swift's `JSONDecoder`. The decoded items are then passed to the `organizeItems(_:)` function.

### Data Organization

The `organizeItems(_:)` function is responsible for filtering out items with null or empty names and sorting the remaining items first by `listId` and then by a numerical value extracted from the item's name. It ensures that items are sorted in a human-intuitive numerical order rather than a simple string-based comparison.
