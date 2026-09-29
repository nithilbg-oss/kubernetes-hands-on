import docker

def main():
    client = docker.from_env()

    print("Building image from Dockerfile...")
    client.images.build(path=".", tag="flask-apparmor")
    print("[INFO] Successfully built flask-apparmor\n")

    print("Running container with AppArmor profile...")
    container = client.containers.run(
        "flask-apparmor",
        ports={'5000/tcp': 5000},
        security_opt=["apparmor=my-apparmor-profile"],
        detach=True
    )
    print(f"Container started: {container.short_id}\n")

    print("Inspecting container to verify AppArmor profile...")
    container_info = client.api.inspect_container(container.id)
    apparmor_profile = container_info['HostConfig']['SecurityOpt']
    print(f"AppArmor profile applied: {apparmor_profile}\n")

    print("Stopping the container...")
    container.stop()
    container.remove()
    print("Container stopped and removed.")

if __name__ == '__main__':
    main()
