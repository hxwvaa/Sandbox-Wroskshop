FROM python:3.12-slim
WORKDIR /workspace
# All lab scripts use Python standard library; no pip install is required.
ENV PYTHONUNBUFFERED=1 PYTHONDONTWRITEBYTECODE=1
CMD ["sleep", "infinity"]
