![grinning_face_with_big_eyes](https://github.com/derpycoder/derpycoder/assets/25662120/d6ed008f-029d-4e72-bd21-4801648281cf)

## Hey there!
Thanks for checking out my git profile.

I am a software engineer from India.

- 🔭 I’m currently working on a Game & Game engine using SDL3 GPU & Odin lang.
- 🌱 Trying to return to the roots, and learn low level programming.
- 💼 I work at Experian, during the day, and spend time on my hobby at night.
- 🤖 I don't like to use GenAI on my personal projects, but, its fair game at work.
- 📫 How to reach me: derpycoder@iclouds.com

![Total Stars](https://img.shields.io/github/stars/derpycoder?style=for-the-badge)

## My Tech Stack

### Professional Experience
![Elixir](https://img.shields.io/badge/Elixir-4B275F?style=for-the-badge&logo=elixir&logoColor=white)
![Phoenix LiveView](https://img.shields.io/badge/-Phoenix%20LiveView-orange?style=for-the-badge&logo=elixir)

![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![Redux](https://img.shields.io/badge/Redux-593D88?style=for-the-badge&logo=redux&logoColor=white)

![JavaScript](https://img.shields.io/badge/JavaScript-323330?style=for-the-badge&logo=javascript&logoColor=F7DF1E)
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)

![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)

### Prior Experience
![Redis](https://img.shields.io/badge/redis-CC0000.svg?&style=for-the-badge&logo=redis&logoColor=white)
![NodeJS](https://img.shields.io/badge/Node%20js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![Socket.IO](https://img.shields.io/badge/Socket.io-010101?&style=for-the-badge&logo=Socket.io&logoColor=white)

![Angular](https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white)

![Unity](https://img.shields.io/badge/Unity-100000?style=for-the-badge&logo=unity&logoColor=white)

## My Coding Adventures & Community Contributions

1. [Proximity Jump Cuts - WIP](https://editor.p5js.org/derpycoder/sketches/9mCIHLJWM)

   I created a custom polygon decomposition algorithm, instead of using existing libraries like Libtess 2, Poly2Tri, Constrained Delaunay Triangulation.
   It works with holes, islands, and has config that can result in aesthetic results, which can speed up Box2D collision detection!
   
   <img width="640" height="638" alt="Proximity Jump Cuts - Custom Polygon Decomposition Algorithm" src="https://github.com/user-attachments/assets/a1b24d3f-52c5-4d3e-a82c-0d9b9afa8f0d" />

   I have used:
   - Doubly Connected Edge List, which helps in extracting the faces from automatically generated polygon decomposition.
   - Spatial Hash, for finding closest inflex vertices quickly without travelling through all the vertices.
   - Conical BFS, for finding vertices that are visible in FOV.
   - Digital Differential Algorithm for filling in Spatial Hash for segments and return stroke for visibility checks.
   - Several computational geometry algorithms like line intersection, orientation checking, etc.
  
   Results:
   
   <img width="733" height="639" alt="Proximity Jump Cuts - Bird" src="https://github.com/user-attachments/assets/6ed1a52f-c0d5-4b2d-a820-3fee3bd1af0d" />
   <img width="444" height="595" alt="Proximity Jump Cuts - Two" src="https://github.com/user-attachments/assets/875efc9d-0314-4aab-86ac-174d60d09338" />
   <img width="641" height="802" alt="Proximity Jump Cuts - Tree" src="https://github.com/user-attachments/assets/50f28716-dcac-465e-b421-960e2ebf7ec5" />
   <img width="778" height="257" alt="Proximity Jump Cuts - Tank" src="https://github.com/user-attachments/assets/6faabcb3-dc06-49ce-8c28-40c2dc155b45" />
   <img width="785" height="769" alt="Proximity Jump Cuts - Monkey" src="https://github.com/user-attachments/assets/acf5f329-47a4-42db-b5bc-02572d222ac6" />
   <img width="792" height="761" alt="Proximity Jump Cuts - Boulder" src="https://github.com/user-attachments/assets/5d4e19ba-4389-462a-8d8e-c960a8047d9c" />

   Compared to Poly2Tri:

   <img width="1669" height="470" alt="Poly2Tri - Tank" src="https://github.com/user-attachments/assets/9a6c17b2-46e2-4972-bf4f-db1e3fda5ef4" />
   <img width="1168" height="980" alt="Poly2Tri - Bird" src="https://github.com/user-attachments/assets/0eb2bb2f-3cd6-49f1-bb62-4efa7cb35bd9" />
   <img width="309" height="494" alt="Screenshot 2026-06-10 at 4 59 50 PM" src="https://github.com/user-attachments/assets/f034b740-1856-4cbc-8317-e723a8933ec5" />

1. Doubly Connected Edge List Data Structure, for use in my custom Polygon Decomposition Algorithm.

   <img width="800" height="800" alt="Hand Connected" src="https://github.com/user-attachments/assets/c345fba9-b57e-48bd-9c62-300ed983517e" />

1. Spatial Hash, Digital Differential Analyzer (DDA) and a lot more!

   <img width="800" height="800" alt="Spatial Hash, DDA, for Proximity Jump Cuts" src="https://github.com/user-attachments/assets/9dfda935-e3ad-4e1e-b10c-5fa57b4b3f5d" />

1. Conical BFS with DDA, to find the closest vertex for use in my custom Polygon Decomposition Algorithm.

   <img width="640" height="638" alt="Conical BFS" src="https://github.com/user-attachments/assets/698c3b0f-d3f1-419b-9195-cbf86027917e" />

1. [I was able to squeeze out 6,50,000 bunnies in bunnymark using SDL3 GPU on a Mac M1!](https://stackoverflow.com/a/79857213/9368649)

   <img width="480" height="280" alt="Jul-02-2026 12-16-01" src="https://github.com/user-attachments/assets/db0e0b10-32ea-41b5-8004-c2b9a33f0218" />

1. I was working on image uploader and converter using Golang, Templ, Tailwind CSS and HTMX.

   <img width="640" height="300" alt="Jul-02-2026 12-18-18" src="https://github.com/user-attachments/assets/88145f08-036d-412a-a2ae-5091db8cfa34" />

   <img width="774" height="282" alt="Jul-02-2026 12-18-54" src="https://github.com/user-attachments/assets/5ee3972b-a712-49b3-aa2f-66d1ebc67521" />

1. Here's a interactive Todo list using Golang and HTMX, which was reorderable and smooth.

   <img width="520" height="380" alt="Jul-02-2026 12-19-15" src="https://github.com/user-attachments/assets/48f8f4d5-17f2-4b99-9a06-5e1eff574868" />

1. [I made a Restaurant Menu for my Brother's hotel.](https://roadside-hotel.onrender.com/)

   <img width="898" height="740" alt="The Roadside Hotel Header" src="https://github.com/user-attachments/assets/b4e7755d-ccdd-45eb-b01a-0ca84b0799ee" />
   <img width="896" height="536" alt="The Roadside Hotel Footer" src="https://github.com/user-attachments/assets/127fed8a-0e55-46ab-aa80-c953acc38371" />

   <img width="554" height="787" alt="The Roadside Hotel QR Code" src="https://github.com/user-attachments/assets/ea6dda6f-cb7e-4642-8edb-4508f39affca" />

1. [Implemented a MTSDF Font for my custom game engine, which can handle 4.5 million font glyphs showing at 60 FPS, on Mac M1!](https://github.com/derpycoder/FontRendering)

   <img width="1276" height="709" alt="Font Renderer" src="https://github.com/user-attachments/assets/66f94f0a-cbdd-4124-bd79-3988013ff338" />
   <img width="690" height="354" alt="Font Render Side View" src="https://github.com/user-attachments/assets/7466dd52-bf4f-4699-b06d-d0a366ee1841" />

   See: [Odin Forum Discussion](https://forum.odin-lang.org/t/i-got-4-5-million-msdf-glyphs-showing-on-mac-m1-using-instancing-why-initial-memory-usage-is-high-compared-to-the-expected-amount/1616).

1. Working on a Custom Game Engine using Odin & SDL3 GPU:

   <img width="1277" height="718" alt="Implemented Radial Fans" src="https://github.com/user-attachments/assets/833d53a0-6d19-41f5-bef9-2f9582aeded0" />
   <img width="1276" height="716" alt="Implemented Custom Shapes with Rounded Corner" src="https://github.com/user-attachments/assets/2355fbe1-c607-4b42-b456-3f4825b3ae82" />
   <img width="850" height="342" alt="Implemented Complex Line Rendering" src="https://github.com/user-attachments/assets/43079419-55a3-4d51-9e05-9808a954259c" />


1. [Watch Face](https://editor.p5js.org/derpycoder/sketches/nIx_l5aFn)

   ![Watch](https://github.com/derpycoder/derpycoder/assets/25662120/d22d5016-f1c5-45d3-b347-38f479c6f489)
   
1. [Flow Field](https://editor.p5js.org/derpycoder/sketches/bqa06RSXi)

   ![Turbulence](https://github.com/derpycoder/derpycoder/assets/25662120/ce48a85e-6f9e-418d-b458-df9f4fc447fa)

1. [Casual Web Game using A* Algorithm](https://derpycoder.github.io/dont-let-him-poo/)

   ![Dont Let Him Poo](https://github.com/derpycoder/derpycoder/assets/25662120/66bb2693-1da1-42e0-9ecc-9ecac2f9bfb3)

1. [Made a Source Code Inspector](https://elixirforum.com/t/made-a-source-code-inspector-useful-in-big-projects-or-large-teams/56792?u=derpycoder) (Which was later added to the Phoenix Live View itself!)
   
   ![Source Code Viewer](https://github.com/derpycoder/derpycoder/assets/25662120/96c39b8b-b391-4a2d-8a2d-fd1a5ba33ee3)
1. [Made a Table of Contents using Floki](https://elixirforum.com/t/i-created-table-of-contents-using-floki-with-header-nesting-how-to-simplify-the-logic/57501/12?u=derpycoder)
   
   ![Table of Contents](https://github.com/derpycoder/derpycoder/assets/25662120/0a70cb29-439f-40c7-bcdc-50ce7b8914ca)
   
1. [Created a Command Palette within a week, thanks to Elixir & Phoenix LiveView](https://elixirforum.com/t/created-a-command-palette-within-a-week-thanks-to-elixir-phoenix-liveview/57769)

   ![global-search](https://github.com/derpycoder/derpycoder/assets/25662120/6569bef4-03b0-4679-8498-afe3ccadf1a5)

1. [Tools](https://github.com/derpycoder/derpy_tools)
   
   ![Metadata Checker](https://github.com/derpycoder/derpycoder/assets/25662120/5194e6cd-aa83-4890-ac71-d5e81072a1c5)
