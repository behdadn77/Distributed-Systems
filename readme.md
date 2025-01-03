
# Distributed Systems Exam Preparation

This repository is a collection of answers to commonly asked questions from past Distributed Systems exams. The answers were primarily generated using GPT-4o and refined using references from the course textbook to ensure accuracy and alignment with the material taught by the professor.

## Structure of the Repository

- **Questions and Answers**: Each question from past exams has a corresponding answer provided in this repository. The answers aim to be comprehensive yet concise, making it easier for students to review and understand key concepts in Distributed Systems.
- **Reference Material**: The `res` folder contains an **unofficial course textbook**, specifically named **FINAL - DS notes col.pdf**, which serves as a reference for providing accurate and professor-aligned responses. This text is crucial for ensuring that explanations and terminologies are consistent with what has been covered in the course.

  - [View FINAL - DS notes col.pdf](./res/FINAL%20-%20DS%20notes%20col.pdf)

## How Answers Were Generated

1. **Initial Answers Using GPT-4o**: Most of the answers were generated using GPT-4o, known for its depth of understanding and ability to handle complex technical content.
2. **Refinement Using Textbook References**: For questions where the initial GPT-4o answers seemed imprecise or deviated from the course material, I provided the relevant sections from **FINAL - DS notes col.pdf** as a reference. These sections were used to refine and correct the answers, ensuring they are accurate and in line with the professor's teachings.

## Compiling the Repository into a PDF

This repository contains Markdown files in various subdirectories (excluding `res`). You can compile these Markdown files, including LaTeX code, into a single PDF with a table of contents based on the directory and file names. The compiled PDF will include anchor links for easier navigation.

### Steps to Compile:

1. **Install Required Tools**:
   - Install `pandoc`: `sudo apt install pandoc` (Linux) or use the package manager for your OS.
   - Install LaTeX distribution (e.g., `TeX Live` or `MikTeX`): `sudo apt install texlive-full`.

2. **Run the Compile Script**:
   Execute the following command in the root directory of the repository:
   ```bash
   pandoc -s --toc --toc-depth=2 -o Distributed_Systems_Exam_Preparation.pdf \
   $(find exercises notes pastExams questions -name '*.md' | sort)
   ```
   - `--toc`: Generates a table of contents.
   - `--toc-depth=2`: Sets the depth of the table of contents to include up to two levels.
   - `-o`: Specifies the output PDF file name.
   - `find ...`: Locates all Markdown files in the specified directories.

3. **Open the PDF**:
   Once compiled, open `Distributed_Systems_Exam_Preparation.pdf` to review the document.

## How to Use This Repository

1. **Review Questions and Answers**: Go through the questions and corresponding answers to solidify your understanding of key Distributed Systems concepts.
2. **Cross-Reference with Textbook**: Use the **FINAL - DS notes col.pdf** in the `res` folder to dive deeper into specific concepts or to verify the accuracy of an answer.
3. **Contribute**: If you find an answer that could be improved or notice any discrepancies, feel free to open an issue or submit a pull request with your suggestions.

## Acknowledgments

- **Alireza**: For gathering the questions from past exams, which provided a foundation for this resource.
- **ChatGPT & GPT-4o**: For generating initial answers and assisting in the learning process.
- **Professor's Material**: The **unofficial course notes** in **FINAL - DS notes col.pdf** were instrumental in ensuring the accuracy and relevancy of the provided answers.

## Disclaimer

This repository is a student-driven resource meant to aid in exam preparation. While efforts have been made to ensure the accuracy of the answers, always refer to the course material and the professor’s notes for the most authoritative information. The **FINAL - DS notes col.pdf** is an **unofficial compilation** and should be used as a supplementary resource.

Happy studying and good luck on your exams!