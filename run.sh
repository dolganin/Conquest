#!/bin/bash

# Скрипт для удобного запуска Doom II AI проекта

# Название проекта
PROJECT_DIR="."
VENV_DIR="venv"

# Путь к WAD файлу
WAD_FILE="$PROJECT_DIR/conquest.wad"

# Проверяем наличие необходимых файлов
if [ ! -f "$WAD_FILE" ]; then
    echo "❌ Файл WAD ($WAD_FILE) не найден. Пожалуйста, поместите conquest.wad в папку проекта."
    exit 1
fi

# Проверяем, существует ли виртуальное окружение
if [ ! -d "$VENV_DIR" ]; then
    echo "🔧 Создание виртуального окружения..."
    python3 -m venv $VENV_DIR
fi

# Активируем виртуальное окружение
source $VENV_DIR/bin/activate

# Устанавливаем зависимости
echo "🔧 Установка зависимостей..."
pip install --upgrade pip
pip install -r $PROJECT_DIR/requirements.txt

# Запрос режима запуска
echo "Выберите режим запуска:"
echo "1) Бот (ИИ играет)"
echo "2) Игрок (Вы управляете)"
read -p "Введите 1 или 2: " mode_choice

if [ "$mode_choice" == "1" ]; then
    MODE="bot"
elif [ "$mode_choice" == "2" ]; then
    MODE="player"
else
    echo "❌ Неверный выбор режима!"
    deactivate
    exit 1
fi

# Запускаем игру
echo "🚀 Запуск Doom II в режиме $MODE ..."
cd $PROJECT_DIR
python3 main.py --mode $MODE

# Выход из виртуального окружения после завершения
deactivate
