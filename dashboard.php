<?php
// Koneksi ke database
$mysqli = new mysqli("localhost", "root", "", "bengkelalhamdulillah");
if ($mysqli->connect_error) {
    die("Koneksi gagal: " . $mysqli->connect_error);
}

// Data untuk dashboard
$total_sparepart = $mysqli->query("SELECT COUNT(*) as total FROM sparepart")->fetch_assoc()['total'];
$total_member = $mysqli->query("SELECT COUNT(*) as total FROM member")->fetch_assoc()['total'];
$total_transaksi = $mysqli->query("SELECT COUNT(*) as total FROM penjualan_sparepart")->fetch_assoc()['total'];

// Data untuk transaksi
$member_result = $mysqli->query("SELECT id_member, nama FROM member");
$result = $mysqli->query("SELECT IFNULL(MAX(id_penjualan), 0) AS last_id FROM penjualan_sparepart");
$last_id = ($result && $row = $result->fetch_assoc()) ? (int)$row['last_id'] : 0;
$next_id = $last_id + 1;
$sparepart_result = $mysqli->query("SELECT * FROM sparepart");

// Simpan transaksi
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['simpan_transaksi'])) {
    $id_penjualan = $_POST['id_penjualan'];
    $tgl_penjualan = $_POST['tgl_penjualan'];
    $grand_total = $_POST['grand_total'];
    $id_member = $_POST['id_member'];

    $tanggal_terformat = date('Y-m-d', strtotime($tgl_penjualan));
    $mysqli->begin_transaction();
    try {
        $stmt = $mysqli->prepare("INSERT INTO penjualan_sparepart (id_penjualan, total_harga, tanggal_penjualan, id_member) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("idss", $id_penjualan, $grand_total, $tanggal_terformat, $id_member);
        $stmt->execute();

        if (isset($_POST['barang'])) {
            foreach ($_POST['barang'] as $barang) {
                $id_sparepart = $barang['id_sparepart'];
                $jumlah = $barang['jumlah'];
                $result_harga = $mysqli->query("SELECT harga FROM sparepart WHERE id_sparepart = $id_sparepart");
                $harga = ($result_harga && $row_harga = $result_harga->fetch_assoc()) ? $row_harga['harga'] : 0;
                $subtotal = $jumlah * $harga;
                $stmt_detail = $mysqli->prepare("INSERT INTO detail_penjualan_sparepart (id_penjualan, id_sparepart, jumlah, subtotal) VALUES (?, ?, ?, ?)");
                $stmt_detail->bind_param("iiid", $id_penjualan, $id_sparepart, $jumlah, $subtotal);
                $stmt_detail->execute();

                $stmt_update = $mysqli->prepare("UPDATE sparepart SET stok = stok - ? WHERE id_sparepart = ?");
                $stmt_update->bind_param("ii", $jumlah, $id_sparepart);
                $stmt_update->execute();
            }
        }

        $mysqli->commit();
        echo "<script>alert('Transaksi berhasil disimpan!');</script>";
    } catch (Exception $e) {
        $mysqli->rollback();
        echo "<script>alert('Transaksi gagal: " . $e->getMessage() . "');</script>";
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PENJUALAN SPAREPART</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center">PENJUALAN SPAREPART</h2>
    <hr>

    <!-- Menu Navigasi -->
    <nav class="nav nav-tabs">
        <a class="nav-link active" href="#dashboard" data-bs-toggle="tab">Dashboard</a>
        <a class="nav-link" href="#transaksi" data-bs-toggle="tab">Transaksi</a>
        <a class="nav-link" href="#laporan" data-bs-toggle="tab">Laporan Penjualan</a>
    </nav>

    <div class="tab-content mt-4">
        <!-- Dashboard -->
     <div class="tab-pane fade show active" id="dashboard">
            <div class="row text-center">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Total Sparepart</h5>
                            <p class="card-text fs-4"><?= $total_sparepart ?></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Total Pelanggan</h5>
                            <p class="card-text fs-4"><?= $total_member ?></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Total Transaksi</h5>
                            <p class="card-text fs-4"><?= $total_transaksi ?></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Transaksi -->
        <div class="tab-pane fade" id="transaksi">
            <form method="POST">
                <h5>DATA TRANSAKSI</h5>
                <div class="mb-3">
                    <label>No. Penjualan</label>
                    <input type="text" name="id_penjualan" class="form-control" value="<?= $next_id ?>" readonly>
                </div>
                <div class="mb-3">
                    <label>Tgl. Penjualan</label>
                    <input type="date" name="tgl_penjualan" class="form-control" value="<?= date('Y-m-d'); ?>" required>
                </div>
                
                <div class="mb-3">
        <label>Pelanggan</label>
        <div class="d-flex">
            <select name="id_member" class="form-control me-2" required>
                <option value="">-- Pilih Pelanggan --</option>
                <?php while ($row = $member_result->fetch_assoc()): ?>
                    <option value="<?= $row['id_member'] ?>"><?= htmlspecialchars($row['nama']) ?></option>
                <?php endwhile; ?>
            </select>
            <a href="tambahpelanggan.php" class="btn btn-primary">+</a>
        </div>
    </div>


                <h5>INPUT SPAREPART</h5>
                <div class="mb-3">
                    <label>Nama Barang</label>
                    <select id="barang" class="form-control" onchange="tampilkanStok()">
                        <option value="">-- Pilih Sparepart --</option>
                        <?php while ($row = $sparepart_result->fetch_assoc()): ?>
                            <option value="<?= $row['id_sparepart'] ?>" data-harga="<?= $row['harga'] ?>" data-stok="<?= $row['stok'] ?>">
                                <?= $row['nama_sparepart'] ?> - Rp. <?= number_format($row['harga'], 2) ?>
                            </option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <div class="mb-3">
                    <label>Total Stok</label>
                    <input type="text" id="total-stok" class="form-control" readonly>
                </div>
                <div class="mb-3">
                    <label>Jumlah</label>
                    <input type="number" id="jumlah" class="form-control" min="1">
                </div>
                <button type="button" id="tambah-barang" class="btn btn-success btn-sm">Tambah</button>
                <hr>

                <h5>DAFTAR BARANG</h5>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Kode</th>
                            <th>Nama Barang</th>
                            <th>Harga</th>
                            <th>Jumlah</th>
                            <th>Subtotal</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody id="daftar-barang"></tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4" class="text-end">Grand Total (Rp):</td>
                            <td id="grand-total">0</td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
                <input type="hidden" name="grand_total" value="0">

                <button type="submit" name="simpan_transaksi" class="btn btn-primary">Simpan Transaksi</button>
            </form>
        </div>

        <!-- Laporan Penjualan -->
        <div class="tab-pane fade" id="laporan">
            <iframe src="laporanpenjualan.php" style="width: 100%; height: 600px; border: none;"></iframe>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Tambah barang ke daftar tabel
    document.getElementById('tambah-barang').onclick = function () {
        let barang = document.getElementById('barang');
        let jumlahInput = document.getElementById('jumlah');
        let jumlah = parseInt(jumlahInput.value);

        // Validasi input
        if (!barang.value || isNaN(jumlah) || jumlah <= 0) {
            alert('Pilih sparepart dan masukkan jumlah yang valid!');
            return;
        }

        // Ambil data dari barang
        let harga = parseFloat(barang.options[barang.selectedIndex].dataset.harga);
        let stok = parseInt(barang.options[barang.selectedIndex].dataset.stok);
        let namaSparepart = barang.options[barang.selectedIndex].text.split(' - ')[0];
        let idSparepart = barang.value;

        // Validasi stok
        if (jumlah > stok) {
            alert('Jumlah yang dimasukkan melebihi stok tersedia!');
            return;
        }

        let subtotal = harga * jumlah;

        // Tambahkan barang ke tabel
        let row = `
            <tr>
                <td><input type="hidden" name="barang[${idSparepart}][id_sparepart]" value="${idSparepart}">${idSparepart}</td>
                <td>${namaSparepart}</td>
                <td>Rp. ${harga.toLocaleString()}</td>
                <td>
                    <input type="hidden" name="barang[${idSparepart}][jumlah]" value="${jumlah}">${jumlah}
                </td>
                <td>Rp. ${subtotal.toLocaleString()}</td>
                <td>
                    <button type="button" class="btn btn-danger btn-sm" onclick="hapusBaris(this)">Hapus</button>
                </td>
            </tr>`;
        document.getElementById('daftar-barang').insertAdjacentHTML('beforeend', row);

        // Reset input dan update total
        jumlahInput.value = '';
        barang.selectedIndex = 0;
        document.getElementById('total-stok').value = '';
        updateGrandTotal();
    };

    // Hitung kembalian
    document.getElementById('hitung-kembalian').onclick = function () {
        let grandTotal = parseFloat(document.querySelector('input[name="grand_total"]').value) || 0;
        let pembayaran = parseFloat(document.getElementById('pembayaran').value);

        if (isNaN(pembayaran) || pembayaran <= 0) {
            alert('Masukkan pembayaran yang valid!');
            return;
        }

        if (pembayaran < grandTotal) {
            alert('Pembayaran tidak boleh kurang dari Grand Total!');
            return;
        }

        let kembalian = pembayaran - grandTotal;
        document.getElementById('kembalian').innerText = `Rp. ${kembalian.toLocaleString()}`;
    };

    // Fungsi untuk menghitung grand total
    function updateGrandTotal() {
        let total = 0;
        document.querySelectorAll('#daftar-barang tr').forEach(row => {
            let subtotal = parseFloat(row.children[4].innerText.replace('Rp. ', '').replace(/,/g, '')) || 0;
            total += subtotal;
        });

        document.getElementById('grand-total').innerText = `Rp. ${total.toLocaleString()}`;
        document.querySelector('input[name="grand_total"]').value = total;
    }

    // Fungsi untuk menghapus baris barang
    function hapusBaris(button) {
        button.closest('tr').remove();
        updateGrandTotal();
    }

    // Tampilkan stok sparepart yang dipilih
    function tampilkanStok() {
        let barang = document.getElementById('barang');
        let stok = barang.options[barang.selectedIndex].dataset.stok || '';
        document.getElementById('total-stok').value = stok;
    }
</script>
</body>
</html>
