class EthAddressFormatter {
  EthAddressFormatter(this.address);
  final String address;
  String mask() {
    return '${address.substring(0, 6)}...${address.substring(address.length - 6, address.length)}';
  }
}
