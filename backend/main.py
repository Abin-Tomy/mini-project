from fastapi import FastAPI 
 
app = FastAPI() 
 
@app.get("/") 
def read_root(): 
    return {"message": "NLP Regional App Backend Running"} 
