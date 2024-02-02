# IOSDev
Project from HSE course "IOS development"

HW2

• Question: What issues prevent us from using storyboards in real projects?
    1. В Storyboards тяжело править конфликты при слиянии изменений.
    2. По мере роста Storyboard навигация в нем становится все сложнее, появляются трудности с отладкой.
    3. Проблемы с производительностью в больших проектах.
    
• Question: What does the code on lines 25 and 29 do?    
    На строке 25 выключается автоматическое создание констрейнтов, тем самым не будет конфликта, при написании своих констрейнтов.
    Title добавляется к иерархии представлений основного view, тем самым будет происходить отрисовка этого элемента на экране.
    
• Question: What is a safe area layout guide?   
    safe area layout guide представляет собой прямоугольник, который ограничивает область, доступную для размещения пользовательского контента, учитывая различные факторы, такие как вырезы под камеру или верхний "бровь" (notch) на iPhone X и более новых устройствах. Он обеспечивает безопасную область для размещения элементов интерфейса, чтобы они не перекрывались системными элементами.
    
• Question: What is [weak self] on line 23 and why it is important? 
    [weak self] - это захват self как слабой ссылки, чтобы избежать создания strong reference. Тем самым мы не будем продлевать жизненый цикл объекта, следовательно избежим утечки памяти.

• Question: What does clipsToBounds mean?
    Cвойство UIView, которое определяет, обрезать ли контент, выходящий за пределы границы представления. Если установлено в true, то все, что выходит за границы, будет обрезано. Если false, то контент может выходить за границы представления.

• Question: What is the valueChanged type? What is Void and what is Double?
    valueChanged имеет тип - функция, принимающая Double и возращающая ничего, которое вызывается при изменении значения слайдера (аналог делегата в C#).
    Void - это тип, представляющий отсутствие значения.
    Double - это тип данных, представляющий числа с плавающей.