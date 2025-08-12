# airbase-streamlit-app

## Local Development

### Setup
```bash
# Create venv (only on initial setup)
python3 -m venv venv

# Activate venv
source venv/bin/activate

# Install dependencies
pip3 install -r requirements.txt

# Start local app
streamlit run main.py
```

## Deployment

Make changes to the code on main branch to trigger Github Actions.

### App Password

Specify the following environment variable if you wish to password protect the entire application.

```bash
PASSWORD=
```

Note that if the environment variable is empty, the check is not enforced.

In your python3 file, include the following to enforce password checks:

```python3
if not check_password():
    st.stop()
```


sudo docker buildx build --no-cache --platform linux/amd64 -t local.gdssingapore:python3.11 .

  /home/linuxbrew/.linuxbrew/bin/python3.11

Unversioned and major-versioned symlinks `python`, `python3`, `python-config`, `python3-config`, `pip`, `pip3`, etc. pointing to
`python3.11`, `python3.11-config`, `pip3.11` etc., respectively, are installed into
  /home/linuxbrew/.linuxbrew/opt/python@3.11/libexec/bin

You can install Python packages with
  pip3.11 install <package>
They will install into the site-package directory
  /home/linuxbrew/.linuxbrew/lib/python3.11/site-packages

`idle3.11` requires tkinter, which is available separately:
  brew install python-tk@3.11

gdbm (`dbm.gnu`) is no longer included in this formula, but it is available separately:
  brew install python-gdbm@3.11
`dbm.ndbm` changed database backends in Homebrew Python 3.11.
If you need to read a database from a previous Homebrew Python created via `dbm.ndbm`,
you'll need to read your database using the older version of Homebrew Python and convert to another format.
`dbm` still defaults to `dbm.gnu` when it is installed.

===========
echo $PATH
/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
===========
$ echo $PATH
/home/linuxbrew/.linuxbrew/opt/python@3.11/libexec/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games