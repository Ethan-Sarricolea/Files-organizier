"""
Description: window to improve code interaction for users
Author: Ethan Sarricolea
"""

import subprocess
from tkinter import messagebox,Tk,Entry,Label,Button,font,filedialog,Frame

def execute(arg1):
    dartPath = r"bin\sorting.dart"
    command = f'dart {dartPath} "{arg1}"'
    if arg1=="":
        messagebox.showwarning("Capy organizier","Please make sure to enter the route")
    else:
        try:
            subprocess.run(command,check=True)
            msj.place(x=200,y=210)
            root.after(5000,msj.place_forget)
        except subprocess.CalledProcessError as e:
            messagebox.showerror("Capy organizier",
                                f"An execution error occurred: {e}")
#"""
def select_dir():
    ruta = str(filedialog.askdirectory())
    userInput.insert("end",ruta)

def start():
    argument = messagebox.askokcancel("Capy organizier",
                           "Are you sure about organizing on the route?")
    if argument:
        execute(userInput.get())

root = Tk()
root.geometry("500x250")
root.title("Organizier")
root.resizable(0,0)

Frame(root,bg="DodgerBlue3",width=500,height=50).place(x=0,y=0)
Label(root,
      font=font.Font(size=25),
      bg="DodgerBlue3",
      foreground="snow",
      text="Capy Organizier").pack(anchor="center")
Label(root,
      font=font.Font(size=10),
      text="Select the path of the folder you want to organize").place(x=60,y=60)
userInput = Entry(root,width=50)
userInput.place(x=50,y=100)
Button(root,
       text="Search path",
       command=(select_dir)).place(x=380,y=98)
Button(root,
       text="Continue",
       width=10,
       bg="springGreen2",
       command=start).place(x=80,y=150)
Button(root,
       text="Quit",
       bg="light coral",
       width=10,
       command=root.quit).place(x=200,y=150)
msj = Label(root,text="Organization finished")
root.mainloop()
#"""
