<?php
// Memulai session
session_start();

$host = 'localhost';
$username = 'root';
$password = ''; 
$database = 'bengkelalhamdulillah'; 
$conn = new mysqli($host, $username, $password, $database);

// Ambil id_member berikutnya
$sqlGetId = "SELECT MAX(id_member) AS max_id FROM member";
$result = $conn->query($sqlGetId);
$row = $result->fetch_assoc();
$nextId = $row['max_id'] + 1;

// Proses form ketika disubmit
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nama_member = $_POST['nama'];
    $alamat = $_POST['alamat'];
    $no_telepon = $_POST['no_telepon'];
    
    // Insert data ke database
    if ($conn->query("INSERT INTO member (id_member, nama, alamat, no_telepon) VALUES ('$nextId', '$nama_member','$alamat','$no_telepon')")) {
        // Menyimpan pesan sukses ke session
        $_SESSION['alert_message'] = 'Data berhasil ditambahkan!';
        
        // Redirect untuk mencegah submit ulang setelah refresh
        header("Location: " . $_SERVER['PHP_SELF']);
        exit; // Menghentikan eksekusi skrip setelah redirect
    } else {
        $_SESSION['alert_message'] = 'Terjadi kesalahan saat menambah data!';
    }
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Pelanggan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Tambah Pelanggan</h1>

        <!-- Menampilkan alert jika ada pesan dari session -->
        <?php if (isset($_SESSION['alert_message'])): ?>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <?= $_SESSION['alert_message'] ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <?php
            // Menghapus pesan setelah ditampilkan
            unset($_SESSION['alert_message']);
            ?>
        <?php endif; ?>

        <form method="POST" action="">
            <div class="mb-3">
                <label for="id_member" class="form-label">ID Pelanggan</label>
                <input type="text" class="form-control" id="id_member" name="id_member" value="<?= $nextId; ?>" readonly>
            </div>
            <div class="mb-3">
                <label for="nama" class="form-label">Nama Pelanggan</label>
                <input type="text" class="form-control" id="nama" name="nama" placeholder="Masukkan nama pelanggan">
            </div>
            <div class="mb-3">
                <label for="alamat" class="form-label">Alamat</label>
                <input type="text" class="form-control" id="alamat" name="alamat" placeholder="Masukkan alamat pelanggan">
            </div>
            <div class="mb-3">
                <label for="no_telepon" class="form-label">No Telpon</label>
                <input type="text" class="form-control" id="no_telepon" name="no_telepon" placeholder="Masukkan nomor telepon">
            </div>
            <button type="submit" class="btn btn-primary">Tambah</button>
            <a href="dashboard.php" class="btn btn-secondary">Kembali</a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
