#!/bin/bash

echo "🛠  ProjectStarter - Hangi dili kullanacaksınız? [c/cpp/python]"
read -r lang

echo "📁 Proje adı nedir?"
read -r project

mkdir -p "$project"
cd "$project" || exit 1

case "$lang" in
  c)
    mkdir -p src include
    touch src/main.c
    cat <<EOF > Makefile
CC = gcc
CFLAGS = -Wall -Wextra -Iinclude
SRC = \$(wildcard src/*.c)
OBJ = \$(SRC:.c=.o)
NAME = $project

all: \$(NAME)

\$(NAME): \$(OBJ)
	\$(CC) \$(CFLAGS) -o \$(NAME) \$(OBJ)

clean:
	rm -f \$(OBJ)

fclean: clean
	rm -f \$(NAME)

re: fclean all
EOF
    ;;
  cpp)
    mkdir -p src include
    touch src/main.cpp
    cat <<EOF > Makefile
CXX = c++
CXXFLAGS = -Wall -Wextra -std=c++98 -Iinclude
SRC = \$(wildcard src/*.cpp)
OBJ = \$(SRC:.cpp=.o)
NAME = $project

all: \$(NAME)

\$(NAME): \$(OBJ)
	\$(CXX) \$(CXXFLAGS) -o \$(NAME) \$(OBJ)

clean:
	rm -f \$(OBJ)

fclean: clean
	rm -f \$(NAME)

re: fclean all
EOF
    ;;
  python)
    mkdir -p src
    echo "print('Hello from $project!')" > src/main.py
    ;;
  *)
    echo "⚠️  Desteklenmeyen dil!"
    exit 1
    ;;
esac

echo "# $project" > README.md
echo -e "*.o\n$project" > .gitignore

echo "✅ $lang projesi oluşturuldu: $project/"
