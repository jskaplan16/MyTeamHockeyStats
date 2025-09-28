<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Email</title>
    <style>
        body {
             font-family: 'Roboto', 'Arial', sans-serif;
            background-color: #185abc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            max-width: 400px;
            width: 100%;
        }
        h2 {
            text-align: center;
            margin-bottom: 1rem;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 1rem;
        }
        input {
            width: 100%;
            padding: 0.6rem;
            margin-top: 0.3rem;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            margin-top: 1.5rem;
            width: 100%;
            padding: 0.7rem;
            border: none;
            background-color: #007BFF;
            color: white;
            font-size: 1rem;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .back-link {
            display: block;
            margin-top: 1rem;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Forgot Your UserName?</h2>
    <p>Please enter your email address, if we find your account we will send you instructions on how to login.</p>
    <form action="actionSendEmail.cfm" method="POST">
        <label for="fullname">User Name</label>
        <input type="text" id="username" name="userNAme" required>
        <button type="submit">Recover Email</button>
    </form>
    <a href="/loginPage.cfm" class="back-link">Back to Login</a>
</div>
<div></div>

</body>
</html>
