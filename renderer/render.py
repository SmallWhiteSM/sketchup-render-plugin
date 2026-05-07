import json
import sys
from PIL import Image, ImageDraw

WIDTH = 800
HEIGHT = 600
SCALE = 1.0  # 控制縮放


def load_model(path):
    with open(path, 'r') as f:
        return json.load(f)


# 簡單 3D → 2D 投影（Orthographic）
def project(vertex):
    x, y, z = vertex

    # 簡單視角（稍微讓它有立體感）
    screen_x = x - y
    screen_y = (x + y) * 0.5 - z

    return (
        int(screen_x * SCALE + WIDTH // 2),
        int(HEIGHT // 2 - screen_y * SCALE)
    )


def render(model, json_path):
    output_path = json_path.replace(".json", ".png")

    image = Image.new("RGB", (WIDTH, HEIGHT), "white")
    draw = ImageDraw.Draw(image)

    for face in model.get("faces", []):
        points = [project(v) for v in face["vertices"]]

        # 填色（隨便給個顏色）
        draw.polygon(points, outline="red", fill="lightgray")

    image.save(output_path)
    print(f"Render complete: {output_path}")


def main():
    if len(sys.argv) < 2:
        print("Usage: python render.py model.json")
        return

    json_path = sys.argv[1]
    model = load_model(json_path)

    render(model, json_path)


if __name__ == "__main__":
    main()