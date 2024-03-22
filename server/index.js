const http = require('http'); // Import the built-in HTTP module
require('dotenv').config();
const mysql = require('mysql2');
const cors = require('cors');
const url = require('url');
const { v4: uuidv4 } = require('uuid');
const jwt = require('jsonwebtoken');
const path = require('path');

const generateToken = (user) => {
  return jwt.sign(
    {
      id: user.id,
      username: user.username,
      email: user.email,
    },
    'postofficeproject',
    {
      expiresIn: '30d',
    }
  );
};

const fs = require('fs');

const db = mysql.createConnection(
{
    host: 'post-office-web-database.mysql.database.azure.com',
    user: 'postofficeadmin',
    password: 'D@tabase123',
    database: 'mydb',
    port: 3306,
    //ssl: {ca: fs.readFileSync('C:\\Users\\rayya.DESKTOP-92F6ECR\\.ssh\\DigiCertGlobalRootCA.crt.pem')}
});




// connect to database
db.connect((err) => {
  if (err) {
      console.log('Not connected to database');
      throw err;
  } else {
      console.log('Connected to database');
  }
});
const handleCors = (req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  res.setHeader('Access-Control-Allow-Credentials', 'true');

  if (req.method === 'OPTIONS') {
      res.writeHead(200);
      res.end();
      return;
  }
};

const server = http.createServer( async (req, res) => {
  // Handle Cors Function To Allow Axios
  handleCors(req, res);

  // Serve static files from the React app
  let filePath = path.join(__dirname, 'client/build', req.url === '/' ? 'index.html' : req.url);
  const extname = String(path.extname(filePath)).toLowerCase();
  const mimeTypes = {
    '.html': 'text/html',
    '.js': 'text/javascript',
    '.css': 'text/css',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpg',
    '.gif': 'image/gif',
    '.svg': 'image/svg+xml',
    '.wav': 'audio/wav',
    '.mp4': 'video/mp4',
    '.woff': 'application/font-woff',
    '.ttf': 'application/font-ttf',
    '.eot': 'application/vnd.ms-fontobject',
    '.otf': 'application/font-otf',
    '.wasm': 'application/wasm'
  };

  fs.readFile(filePath, function(error, content) {
    if (error) {
      if(error.code == 'ENOENT'){
        fs.readFile('./404.html', function(error, content) {
          res.writeHead(404, { 'Content-Type': 'text/html' });
          res.end(content, 'utf-8');
        });
      }
      else {
        res.writeHead(500);
        res.end('Sorry, check with the site admin for error: '+error.code+' ..\n');
        res.end(); 
      }
    }
    else {
      res.writeHead(200, { 'Content-Type': mimeTypes[extname] || 'application/octet-stream' });
      res.end(content, 'utf-8');
    }
  });

  // GET Requests 
  if (req.method === "GET") {
    if (req.url === "/") {
      res.setHeader('Content-Type', 'text/html');
      res.write('<html><head><title>Hello, World!</title></head><body><h1>Hello, World!</h1></body></html>');
      res.end();
    }
    // Get ALl Users
    else if (req.url === "/users") 
    {
      db.query(
        "SELECT * FROM customer_user",
        (error, result) => {
          if (error) {
            res.writeHead(500, { "Content-Type": "application/json" });
            res.end(JSON.stringify({ error: error }));
          } else {
             res.writeHead(200, { "Content-Type": "application/json" });
            res.end(JSON.stringify(result));
          }
        }
      );
    }
    // Get ALl Customers
    else if (req.url === "/customers") 
    {
      db.query(
        "SELECT * FROM customer",
        (error, result) => {
          if (error) {
            res.writeHead(500, { "Content-Type": "application/json" });
            res.end(JSON.stringify({ error: error }));
          } else {
             res.writeHead(200, { "Content-Type": "application/json" });
            res.end(JSON.stringify(result));
          }
        }
      );
    }
    // Get ALL packages
    else if (req.url === "/package") 
    {
      db.query(
        "SELECT * FROM package",
        (error, result) => {
          if (error) {
            res.writeHead(500, { "Content-Type": "application/json" });
            res.end(JSON.stringify({ error: error }));
          } else {
             res.writeHead(200, { "Content-Type": "application/json" });
            res.end(JSON.stringify(result));
          }
        }
      );
    }
    // Get ALL transactions
    else if (req.url === "/transaction") 
    {
      db.query(
        "SELECT * FROM transaction",
        (error, result) => {
          if (error) {
            res.writeHead(500, { "Content-Type": "application/json" });
            res.end(JSON.stringify({ error: error }));
          } else {
             res.writeHead(200, { "Content-Type": "application/json" });
            res.end(JSON.stringify(result));
          }
        }
      );
    }
  }
  else if (req.method === "POST") {
    if (req.url === "/register") {
      let data = "";
      req.on("data", (chunk) => {
          data += chunk;
      });
      const currentDate = new Date();
      const formattedDate = currentDate.toISOString().slice(0, 19).replace('T', ' ');
      req.on("end", () => {
          const body = JSON.parse(data);
          const userid = uuidv4().substring(0,10);
          const firstname = body.firstname;
          const lastname = body.lastname; 
          const username = body.username;
          const password = body.password;
          const phoneNumber = body.phoneNumber;
          const email = body.email;
          const dateSignup = formattedDate; 
          const role = 'User';
          const address = body.address;
          
          db.query(
            "INSERT INTO customer_user (UserID, CustomerUser, CustomerPass, Email, firstname, lastname, address, phonenumber, dateSignedUp, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
              [userid, username, password, email, firstname, lastname, address, phoneNumber, dateSignup, role],
              (error) => {
                  if (error) {
                    console.log(error);
                    res.writeHead(500, {"Content-Type": "application/json"});
                    res.end(JSON.stringify({error: "Do we get this far?"}));
                  } else {
                    res.writeHead(200, {"Content-Type": "application/json"});
                    res.end(JSON.stringify({ message: "User has signed up successfully" }));
                  }
              }
          );
      });
    }
    else if (req.url === "/login") {
      let data = "";
      req.on("data", (chunk) => {
        data += chunk;
      });
      
      req.on("end", () => {
        const body = JSON.parse(data);
        const username = body.username;
        const password = body.password;
    
        // Here, make sure you are hashing and comparing passwords correctly if using hashing
        // If passwords are hashed, compare the hash of the provided password with the stored hash
        db.query(
          "SELECT * FROM customer_user WHERE CustomerUser = ?",
          [username],
          (error, results) => {
            if (error) {
              res.writeHead(500, { "Content-Type": "application/json" });
              res.end(JSON.stringify({ error: 'Internal Server Error' }));
            } else {
              if (results.length > 0) {
                const user = results[0]; // Assuming user is found in the first result

                const userRole = user.role;
                // Check if the provided password matches the stored password
                // If you're using hashed passwords, this is where bcrypt.compare would be used
                if (user.CustomerPass === password) {
                  // Generate token
                  const token = generateToken(user);
                  // Send user details and token in response
                  res.writeHead(200, { 'Content-Type': 'application/json' });
                  res.end(JSON.stringify({
                    id: user.UserID,
                    username: user.CustomerUser,
                    email: user.Email,
                    role: userRole,
                    token: token
                  }));
                } else {
                  // Password does not match
                  res.writeHead(401, { "Content-Type": "application/json" });
                  res.end(JSON.stringify({ message: "Wrong username or password" }));
                }
              } else {
                // No user found
                res.writeHead(401, { "Content-Type": "application/json" });
                res.end(JSON.stringify({ message: "Wrong username or password" }));
              }
            }
          }
        );
      });
    }
    
  }
  else if(req.method == "DELETE") {
    const reqURL = url.parse(req.url, true);
    const pathSegments = reqURL.pathname.split("/");
  }
});

const port = process.env.PORT || 4000; // Use environment variable or default port
server.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
