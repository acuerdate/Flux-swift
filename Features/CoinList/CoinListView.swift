import SwiftUI

struct CoinListView: View {

    @StateObject private var viewModel = CoinListViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Flux")
                .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await viewModel.loadCoins()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Загрузка...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loaded(let coins):
            List {
                Section {
                    searchBar
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)

                Section {
                    ForEach(filtered(coins)) { coin in
                        CoinRow(coin: coin)
                    }
                }
            }
            .listStyle(.plain)

        case .failed(let message):
            errorView(message: message)
        }
    }

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Поиск монеты", text: $viewModel.searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.top, 8)
    }

    private func filtered(_ coins: [Coin]) -> [Coin] {
        if viewModel.searchText.isEmpty { return coins }
        return coins.filter {
            $0.name.localizedCaseInsensitiveContains(viewModel.searchText)
        }
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 12) {
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button("Повторить") {
                Task { await viewModel.loadCoins() }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CoinListView()
}
