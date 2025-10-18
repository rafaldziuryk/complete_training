# Number Facts API

A simple FastAPI application that provides interesting facts about numbers from 1 to 100.

## Features

- **Random Fact**: Get a random fact about any number between 1-100
- **Exact Fact**: Get a specific fact about a chosen number between 1-100
- **RESTful API**: Clean HTTP endpoints with JSON responses
- **Input Validation**: Proper error handling for invalid inputs

## Endpoints

### GET /
Returns API information and available endpoints.

### GET /random
Returns a random fact about a number between 1 and 100.

**Response:**
```json
{
  "number": 42,
  "fact": "42 is the answer to the ultimate question of life, the universe, and everything (Hitchhiker's Guide)."
}
```

### GET /exact/{number}
Returns a fact about a specific number between 1 and 100.

**Parameters:**
- `number` (int): The number to get a fact about (1-100)

**Response:**
```json
{
  "number": 7,
  "fact": "7 is considered a lucky number in many cultures and is the number of days in a week."
}
```

**Error Response (400):**
```json
{
  "detail": "Number must be between 1 and 100"
}
```

## Setup and Running

### Local Development

1. **Create virtual environment:**
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Run the server:**
   ```bash
   python main.py
   ```
   
   Or with uvicorn directly:
   ```bash
   uvicorn main:app --host 0.0.0.0 --port 8000 --reload
   ```

4. **Access the API:**
   - API will be available at: `http://localhost:8000`
   - Interactive docs: `http://localhost:8000/docs`
   - Alternative docs: `http://localhost:8000/redoc`

### Deploy to Render.com

1. **Push to GitHub repository**
2. **Connect to Render.com:**
   - Go to [Render.com](https://render.com)
   - Create new Web Service
   - Connect your GitHub repository
   - Select the `api` folder as root directory
   - Use Python environment
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `python main.py`

3. **Environment Variables:**
   - `PORT`: Automatically set by Render.com
   - `PYTHON_VERSION`: 3.9.18

### Deploy with Docker

1. **Build Docker image:**
   ```bash
   docker build -t number-facts-api .
   ```

2. **Run container:**
   ```bash
   docker run -p 8000:8000 number-facts-api
   ```

## Example Usage

```bash
# Get a random fact
curl http://localhost:8000/random

# Get a specific fact
curl http://localhost:8000/exact/42

# Get API info
curl http://localhost:8000/
```

## Dependencies

- **FastAPI**: Modern, fast web framework for building APIs
- **Uvicorn**: ASGI server for running FastAPI applications
- **Pydantic**: Data validation using Python type annotations
