from bs4 import BeautifulSoup
html = open('original.html','r')
soup = BeautifulSoup(html, 'html.parser')
texts = soup.findAll(text=True)

def visible(element):
    if element.parent.name in ['style', 'script', '[document]', 'head', 'title']:
        return False
    return True

visible_texts = filter(visible, texts)
print (visible_texts)
