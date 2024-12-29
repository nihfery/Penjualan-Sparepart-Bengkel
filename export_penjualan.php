<?php
$conn = new mysqli("localhost", "root", "", "bengkelalhamdulillah");
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

$tgl_penjualan = isset($_GET['tgl_penjualan']) ? $_GET['tgl_penjualan'] : date('Y-m-d');

$sql = "SELECT ps.tanggal_penjualan, ps.id_penjualan, m.nama AS pelanggan, ps.total_harga 
        FROM penjualan_sparepart ps 
        JOIN member m ON ps.id_member = m.id_member 
        WHERE ps.tanggal_penjualan = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $tgl_penjualan);
$stmt->execute();
$result = $stmt->get_result();

header("Content-Type: application/vnd.ms-excel");
header("Content-Disposition: attachment; filename=Laporan_Penjualan_" . date('Ymd') . ".xls");

echo "Tanggal\tID Penjualan\tPelanggan\tTotal Belanja\n";
while ($row = $result->fetch_assoc()) {
    echo "{$row['tanggal_penjualan']}\t{$row['id_penjualan']}\t{$row['pelanggan']}\t{$row['total_harga']}\n";
}

$stmt->close();
$conn->close();
?>
