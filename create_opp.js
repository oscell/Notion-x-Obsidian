const fs = require('fs');
const path = require('path');

// Capture command-line arguments
const args = process.argv.slice(2);
const oppName = args[0];
const aeName = args[1];
const websites = args[2].split(','); // Split comma-separated websites into an array

// Simulate the AE selection
const AEs_name = ['Amir Seoudy', 'Caolan McBreen', 'Colin Reingewirtz', 'Eduardo Capuano', 'Elias Kharrat', 'Gibril Farah', 'Labeed AhmadQamar'];

// Validate AE name
if (!AEs_name.includes(aeName)) {
  console.error('Invalid AE name provided.');
  process.exit(1);
}

// Generate the file content
const AE_link = path.join('/Resources/People', `${aeName}.md`);
const websiteContent = websites.map(link => `[Website::${link}] |`).join('\n');

const fileContent = `###### Overview
[App::] | [SlackChannel::] | ${websiteContent} | [Opp::SF] [Calc] | [AE::[[${AE_link}|${aeName}]]] | \`$=if(dv.current().calc != "Calc"){ dv.current().calc}else{"[[#Scoping|Add Calc]]"} \` | \`$=if(dv.current().questionnaire != "Q"){ dv.current().questionnaire}else{"[[#Scoping|Add Questionaire]]"} \` \`$=if(dv.current()["Solutions Guide"]){ "| " + dv.current()["Solutions Guide"]}else{""} \`

## Technical discovery
[[Prepping a Pre-Sales Call at Algolia#Steps to prepping the first technical workshop|Prepping the first technical workshop]]

### Previous notes
### Search audit
[[UI & UX]]
### Questions

### Notes
#### Who We Met

## Scoping
[Calc::Calc] | [Questionnaire::Q] | \`$= dv.current().app\`

## Solutions Guide
[Solutions Guide::] | \`$=if(dv.current().calc != "Calc"){ dv.current().calc}else{"[[#Scoping|Add Calc]]"} \` | \`$=if(dv.current().questionnaire != "Q"){ dv.current().questionnaire}else{"[[#Scoping|Add Questionaire]]"} \` 

### Data

## Implems
Website: \`$= dv.current().website\`

## Messages
\`\`\`dataview
TABLE
FROM [[]]
WHERE type = [[+Communication]]
\`\`\`

## Tasks
- [ ] [[#Scoping|Scope]]
- [ ] [[Tech call Follow ups|Follow up]]`;

// Create the file
const fileName = `${oppName}.md`; // Use a timestamp or another naming convention
const filePath = path.join('/Users/oscar.meunier/Documents/Obsidian/AlgoVault/Resources/Opportunities', fileName);

fs.writeFileSync(filePath, fileContent);

console.log(`File created at ${filePath}`);