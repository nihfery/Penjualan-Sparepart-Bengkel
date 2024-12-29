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

// Query untuk data grafik penjualan harian
$sql_chart = "SELECT DATE_FORMAT(tanggal_penjualan, '%Y-%m-%d') AS hari, SUM(total_harga) AS total 
              FROM penjualan_sparepart 
              GROUP BY DATE_FORMAT(tanggal_penjualan, '%Y-%m-%d')";
$result_chart = $conn->query($sql_chart);

$hari = [];
$total_penjualan_harian = [];
if ($result_chart) {
    while ($row_chart = $result_chart->fetch_assoc()) {
        $hari[] = $row_chart['hari'];
        $total_penjualan_harian[] = $row_chart['total'];
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laporan Penjualan Sparepart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="container mt-5">
    <div class="card mt-4">
        <div class="card-body">
            <form method="get" action="">
                <div class="row">
                    <div class="col-md-6">
                        <label for="tgl_penjualan" class="form-label">Pilih Tanggal</label>
                        <input type="date" name="tgl_penjualan" id="tgl_penjualan" class="form-control" value="<?= $tgl_penjualan; ?>" required>
                    </div>
                    <div class="col-md-3 align-self-end">
                        <button type="submit" class="btn btn-primary">Tampilkan</button>
                    </div>
                    <div class="col-md-3 align-self-end">
                        <a href="export_penjualan.php?tgl_penjualan=<?= $tgl_penjualan ?>" class="btn btn-success">Export ke Excel</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="table-responsive mt-4">
        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>No</th>
                    <th>Tanggal</th>
                    <th>ID Penjualan</th>
                    <th>Pelanggan</th>
                    <th>Total Belanja (Rp)</th>
                    <th>Tools</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $no = 1;
                while ($row = $result->fetch_assoc()): ?>
                    <tr>
                        <td><?= $no++ ?></td>
                        <td><?= date('d-m-Y', strtotime($row["tanggal_penjualan"])) ?></td>
                        <td><?= htmlspecialchars($row["id_penjualan"]) ?></td>
                        <td><?= htmlspecialchars($row["pelanggan"]) ?></td>
                        <td><?= number_format($row["total_harga"], 0, ',', '.') ?></td>
                        <td>
                            <a href="nota.php" class="btn btn-info btn-sm">Nota</a>
                        </td>
                    </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    </div>

    <!-- Grafik Penjualan -->
    <div class="card mt-4">
        <div class="card-body">
            <h5 class="card-title">Grafik Penjualan Harian</h5>
            <canvas id="grafikPenjualan"></canvas>
        </div>
    </div>
</div>

<script>
    const ctx = document.getElementById('grafikPenjualan').getContext('2d');
    const grafikPenjualan = new Chart(ctx, {
        type: 'line',
        data: {
            labels: <?= json_encode($hari) ?>,
            datasets: [{
                label: 'Total Penjualan Harian (Rp)',
                data: <?= json_encode($total_penjualan_harian) ?>,
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 2,
                tension: 0.4  // Menambahkan kelengkungan pada garis
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<?php
$stmt->close();
$conn->close();
?>
