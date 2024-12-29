<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Struk Penjualan</title>
    <!-- Link Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Courier New', Courier, monospace;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f4f4f9;
        }
        .struk-container {
            width: 320px;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: #fff;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-bottom: 20px; /* Menambahkan jarak antara struk dan tombol */
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h4 {
            font-size: 20px;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .header p {
            font-size: 14px;
            margin: 0;
        }
        .items-table {
            width: 100%;
            margin-top: 15px;
            border-collapse: collapse;
        }
        .items-table th, .items-table td {
            font-size: 14px;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }
        .items-table th {
            text-align: left;
            background-color: #f8f9fa;
        }
        .items-table td {
            text-align: right;
        }
        .total {
            font-size: 16px;
            font-weight: bold;
            text-align: right;
            margin-top: 20px;
        }
        .total p {
            margin: 5px 0;
        }
        .print-wrapper {
            text-align: center;
        }
        .btn-print {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn-print:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<?php
// Koneksi ke database
$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'bengkelalhamdulillah'; // Ganti dengan nama database Anda

$conn = new mysqli($host, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Mengambil data penjualan
$id_penjualan = 1; // Ganti dengan ID penjualan yang ingin ditampilkan
$query_penjualan = "SELECT tanggal_penjualan FROM penjualan_sparepart WHERE id_penjualan = ?";
$stmt_penjualan = $conn->prepare($query_penjualan);
$stmt_penjualan->bind_param("i", $id_penjualan);
$stmt_penjualan->execute();
$result_penjualan = $stmt_penjualan->get_result();
$row_penjualan = $result_penjualan->fetch_assoc();

$tanggal = $row_penjualan['tanggal_penjualan'];

// Mengambil detail penjualan
$query_detail = "SELECT s.nama_sparepart, s.harga, d.jumlah, d.subtotal 
                  FROM detail_penjualan_sparepart d
                  JOIN sparepart s ON d.id_sparepart = s.id_sparepart
                  WHERE d.id_penjualan = ?";
$stmt_detail = $conn->prepare($query_detail);
$stmt_detail->bind_param("i", $id_penjualan);
$stmt_detail->execute();
$result_detail = $stmt_detail->get_result();

$items = [];
while ($row = $result_detail->fetch_assoc()) {
    $items[] = $row;
}
$stmt_detail->close();
$stmt_penjualan->close();
$conn->close();
?>
    <div class="struk-container">
        <!-- Header Nota -->
        <div class="header">
            <h4>STRUK PENJUALAN</h4>
            <p>No. Nota: <?php echo $id_penjualan; ?></p>
            <p>Tanggal: <?php echo $tanggal; ?></p>
        </div>

        <!-- Daftar Barang -->
        <table class="table items-table">
            <thead>
                <tr>
                    <th>Nama Barang</th>
                    <th>Harga</th>
                    <th>Jumlah</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $grandTotal = 0;
                foreach ($items as $item) {
                    $grandTotal += $item['subtotal'];
                    echo "<tr>
                            <td>{$item['nama_sparepart']}</td>
                            <td>Rp " . number_format($item['harga'], 0, ',', '.') . "</td>
                            <td>{$item['jumlah']}</td>
                            <td>Rp " . number_format($item['subtotal'], 0, ',', '.') . "</td>
                          </tr>";
                }
                ?>
            </tbody>
        </table>

        <!-- Total Pembayaran -->
        <div class="total">
            <p>Total: Rp <?php echo number_format($grandTotal, 0, ',', '.'); ?></p>
        </div>
    </div>
    

    <!-- Link Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
