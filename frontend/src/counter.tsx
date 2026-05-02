interface ButtonProps
{
    count: number;
    setCount: (value: number) => void;
}

export function INCREMENT_Button({count, setCount}: ButtonProps)
{
    const increment = () => {
        setCount(count + 1);
    };

    return (
        <>
            {
            <section id = "center">
                <button onClick={increment}>increment</button>
            </section>

            }
        </>
    )
}


export function DECREMENT_Button({count, setCount}: ButtonProps)
{

    const decrement = () => {setCount(count - 1);}

    return (
        <>
        {
            <section id = "center">
                <button onClick={decrement}>decrement</button>
            </section>
        }
        </>
    )
}