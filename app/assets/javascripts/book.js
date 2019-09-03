document.addEventListener('turbolinks:load', () => { 
    getBooks()
    .then(res => res.json())
    .then(books => displayBooks(books))
    .catch(err => displayError("Books not Found"))

    let add = document.getElementById('add_book')
    add.addEventListener('click', (e) => {
        console.log('test')
        displayForm(document)
        //addBook()
    })
})

const getBooks = () => {
    return myFetch(`/books.json`)
}

const displayBooks = (results) => {
    let html = results.map(bookData => new Book(bookData).render()).join('')
    document.getElementById('books').innerHTML = html

    let showBooks = document.querySelectorAll('.book')
    showBooks.forEach(function(element) {
        element.addEventListener('click', (e) => {

            let test = e.target.href

            getBook(e.target.href)
            .then(res => res.json())
            .then(book => displayBook(book))
            //.catch(err => displayBookError("Book not Found"))

            let addReview = document.getElementById('to_book')
            addReview.addEventListener('click', (e) => {
                window.location.href = test
            })
        })
    })
}

const displayError = (error) => {
    document.getElementById('books').innerHTML = error;
}

//Book
const getBook = (book_url) => {
    return myFetch(`${book_url}.json`)
}

const displayBook = (results) => {
    let html = new Book(results).renderShow()
    document.getElementById('book').innerHTML = html
}

const displayBookError = (error) => {
    document.getElementById('book').innerHTML = error;
}

//add book
const addBook = () => {
    console.log('from add book')
}

const displayForm = () => {
    document.getElementById('add_space').innerHTML = 'test'
}
  

class Book {
    constructor(attributes) {
        this.title = attributes.title
        this.auther = attributes.auther
        this.id = attributes.id
        this.reviews = attributes.reviews
    }
    render() {
        return `
            <div class="book"><a href="/books/${this.id}" onclick="return false;">${this.title}</a></div>
        `
    }
    renderShow() {
        return `
            <div>
                <h3>Title: ${this.title}</h3>
                <h3>Auther: ${this.auther}</h3>
                <h3>Reviews</h3>
                ${this.renderReviews()}
            </div>
        `
    }
    renderReviews() {
        return `
            ${this.reviews.map(review => `<p>${review.description}</p>`).join('')}
        `
    }
}


