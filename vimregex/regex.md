- convert casbin-rs enforce method's signature
  ```bash
  :%s/enforce(&\[\(.*\)\])/enforce((\1))/g
  ```
