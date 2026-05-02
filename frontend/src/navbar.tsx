import logo from './assets/mokoko.png'; 

export function NavBar()
{
    return (
        <nav className="navbar">
            <div className="navbar-logo"><img src= {logo}/></div>
            <ul className="navbar-links">
                <li><a href="home">home</a></li>
                <li><a href="project">project</a></li>
                <li><a href="about">about</a></li>
            </ul>
        </nav>
    )
}