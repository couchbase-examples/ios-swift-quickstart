enum Destination: Hashable {
    case hotelForm(viewMode: HotelFormViewModel.ViewMode)
    case hotelDetails(hotel: Hotel)
}
