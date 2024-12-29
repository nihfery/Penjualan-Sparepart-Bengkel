<?php
$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'bengkelapasi';

$conn = new mysqli($host, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

if (isset($_GET['delete'])) {
    $id_vendor = $_GET['delete'];
    $stmt = $conn->prepare("DELETE FROM vendor WHERE id_vendor = ?");
    $stmt->bind_param("i", $id_vendor);
    $stmt->execute();
    $stmt->close();
    header("Location: {$_SERVER['PHP_SELF']}?msg=deleted");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_vendor = $_POST['id_vendor'];
    $nama_vendor = $_POST['nama_vendor'];
    if (isset($_POST['edit']) && $_POST['edit'] == '1') {
        $stmt = $conn->prepare("UPDATE vendor SET nama_vendor = ? WHERE id_vendor = ?");
        $stmt->bind_param("si", $nama_vendor, $id_vendor);
    } else {
        $stmt = $conn->prepare("INSERT INTO vendor (id_vendor, nama_vendor) VALUES (?, ?)");
        $stmt->bind_param("is", $id_vendor, $nama_vendor);
    }
    $stmt->execute();
    $stmt->close();
    header("Location: {$_SERVER['PHP_SELF']}?msg=success");
    exit;
}
$result = $conn->query("SELECT * FROM vendor");
$next_id_result = $conn->query("SELECT MAX(id_vendor) AS max_id FROM vendor");
$next_id = 1;
if ($next_id_result && $row = $next_id_result->fetch_assoc()) {
    $next_id = $row['max_id'] + 1;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="btn btn-secondary mb-4">
            <h1>Vendor Management</h1>
        </div>
        <div class="card-body">
            <!-- Form Tambah/Edit Vendor -->
            <form method="POST" class="mb-4">
                <div class="row g-3">
                    <div class="col-md-4">
                        <input type="number" name="id_vendor" class="form-control" placeholder="ID Vendor" id="id_vendor" value="<?php echo $next_id; ?>" readonly required>
                    </div>
                    <div class="col-md-4">
                        <input type="text" name="nama_vendor" class="form-control" placeholder="Nama Vendor" id="nama_vendor" required>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-success w-100" id="submit_button">Tambah Vendor</button>
                        <input type="hidden" name="edit" id="edit_flag" value="0">
                    </div>
                </div>
            </form>

            <!-- Tabel Vendor -->
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th scope="col">ID Vendor</th>
                            <th scope="col">Nama Vendor</th>
                            <th scope="col" class="text-center">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        if ($result->num_rows > 0) {
                            $no = 1;
                            while ($row = $result->fetch_assoc()) {
                                echo "<tr>";
                                echo "<td>{$row['id_vendor']}</td>";
                                echo "<td>{$row['nama_vendor']}</td>";
                                echo "<td class='text-center'>
                                    <button class='btn btn-warning btn-sm edit-button' data-id='{$row['id_vendor']}' data-name='{$row['nama_vendor']}'>Edit</button>
                                    <a href='?delete={$row['id_vendor']}' class='btn btn-danger btn-sm'>Delete</a>
                                </td>";
                                echo "</tr>";
                                $no++;
                            }
                        } else {
                            echo "<tr><td colspan='4' class='text-center'>Tidak ada data vendor</td></tr>";
                        }
                        ?>
                    </tbody>
                </table>
            </div>
            <a href="dashboard.php" class="btn btn-secondary">Kembali</a>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Edit Button Functionality
    document.querySelectorAll('.edit-button').forEach(button => {
        button.addEventListener('click', () => {
            const id = button.getAttribute('data-id');
            const name = button.getAttribute('data-name');
            document.getElementById('id_vendor').value = id;
            document.getElementById('nama_vendor').value = name;
            document.getElementById('submit_button').textContent = 'Update Vendor';
            document.getElementById('edit_flag').value = '1';
            document.getElementById('submit_button').classList.remove('btn-success');
            document.getElementById('submit_button').classList.add('btn-primary');
        });
    });
</script>
</body>
</html>
