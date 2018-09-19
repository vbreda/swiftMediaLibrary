# Repository: brevi593

|           |              |
|-----------|--------------|
| Raw       | 18.6/20   |
| Bonus     | 3/3  |
| Total     | 20/20 |


## Design			
								
| Assignment of Responsibilities | Cohesion | Coupling | Inheritance | Composition |	
|--------------------------------|----------|----------|-------------|-------------|
| 5 / 5       | 5 / 5 | 5 / 5 | 5 / 5 | 5 / 5 |


## Implementation
		
| Visibility                     | Additional protocols | Comments          |
|--------------------------------|----------------------|-------------------|
| 5 / 5             | 0 / 5    | 8 / 10 |

## Functionality				
| Import         | Export            | Search         | Edit         |
|----------------|-------------------|----------------|--------------|
| 5 / 5 | 5 / 5    | 5 / 5 | 5 / 5 |	

## Misc

| Quality        | Idiomatic Swift   | JSON data matches spec | Git commit log |
|----------------|-------------------|------------------------|----------------|
| 5 /5 | 5 /5  | 1 /1            | 2 /2     |
			

## Design Patterns	

| Appropriate            |
|------------------------|
| 5 /5 |	

## Testing	

| Thoroughness        |
|---------------------|
| 5 /5 |	

## Report
| Design        | Testing        | Role          | Spelling/Grammar/etc. errors |
|---------------|----------------|---------------|------------------------------|
| 4 /4 | 4 /4 | 4 /4 | 0               | 


## My Comments

I like that you've separated the validation of files into it’s own class. At this point, I’m nitpicking, but in the checking for duplicates, you can simply return as soon as you find the first instance -- I don’t need to continue through the rest of the collection. You’ve also specified the required metadata properties twice in your application -- would it not make sense for each file type to specify its own required metadata? The loader can then ask based on the ‘type’ from the JSON data. How much extra work would it be to add a new file type to your validation?  ✅ Nikolah and Vivian passed asgn1 - woohoo!