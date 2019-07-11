// The Algorithm: "Bubbling Up" //

// As we progress through the algorithms and data structures of this course, 
// you'll eventually notice that there are some reoccuring funny terms. 
// "Bubbling up" is one of those terms.

// When we say that an item in a collection "bubbles up," we imply that:

// - The item is in motion.
// - The item is moving in some direction.
// - The item has some final resting destination.

// When invoking Bubble Sort, if we are sorting an array of integers so 
// that they occur in ascending order, the largest integers will "bubble up" 
// to the "top" (the end) of the array, one at a time.

// The largest values are captured, put into motion in the direction defined 
// by our desired sort(ascending right now), and traverse the array until 
// they arrive at their end destination. See if you can observe this 
// behavior in the following animation(courtesy http://visualgo.net):

// As we iterate through the array, we compare each element to its right neighbor. 
// If the current element is larger than its neighbor, we swap them.

// Wash, rinse, repeat, until all elements of the array are sorted.

// How does a pass of Bubble Sort work? //

// Bubble sort works by performing multiple passes to move elements 
// closer to their final positions. A single pass will iterate through the entire 
// array once.

// A pass works by scanning the array from left to right, two elements at a time, 
// and checking if they are ordered correctly. To be ordered correctly the first element 
// must be less than or equal to the second. If the two elements are not ordered 
// properly, then we swap them to correct their order. Afterwards, we scan the next 
// two numbers and continue repeat this process until we have gone through the entire array.

// Let's see one pass of bubble sort on the array [2, 8, 5, 2, 6]. On each step the 
// elements currently being scanned are in bold.

// - 2, 8, 5, 2, 6 - ordered, so leave them alone
// - 2, 8, 5, 2, 6 - not ordered, so swap
// - 2, 5, 8, 2, 6 - not ordered, so swap
// - 2, 5, 2, 8, 6 - not ordered, so swap
// - 2, 5, 2, 6, 8 - our first pass is complete

// How do we know when we are done Bubble Sorting? //

// During Bubble Sort, we can tell if the array is in sorted order by checking if we made 
// a swap during the previous pass performed. If a swap was not performed during 
// the previous pass, then the array must be totally sorted and we can stop the algorithm.

// You're probably wondering why that makes sense. Recall that a pass of Bubble Sort checks 
// if any adjacent elements are out of order and swaps them if they are. If we don't make 
// any swaps during a pass, then everything must be already in order, so our job is done.
// Let that marinate for a bit.

// Swapping Elements //

// Like we saw in the previous example, Bubble Sort manipulates the array by swapping the 
// position of two elements. To implement Bubble Sort in JS, we'll need to perform this 
// operation, so let's build a helper function. A key detail in this function is 
// that we need an extra letiable to store one of the elements since we will be overwriting 
// them in the array:

function swap(array, idx1, idx2) {
  let temp = array[idx1];     // save a copy of the first ele
  array[idx1] = array[idx2];  // overwrite the first ele with the second ele
  array[idx2] = temp;         // overwrite the second ele with the first ele copy
}

// Note that the swap function does not create or return a new array. It mutates the 
// original array:

let arr1 = [2, 8, 5, 2, 6];
swap(arr1, 1, 2);
arr1; // => [ 2, 5, 8, 2, 6 ]

// Bubble Sort JS Implementation //

// Using swap and our newfound understanding of Bubble Sort, let's code! Take a look at 
// the snippet below and try to understand how it corresponds to our conceptual 
// understanding of the algorithm. Scroll down to the commented version when you get stuck.

function bubbleSort(array) {
  let swapped = true;

  while (swapped) {
    swapped = false;

    for (let i = 0; i < array.length - 1; i++) {
      if (array[i] > array[i + 1]) {
        swap(array, i, i + 1);
        swapped = true;
      }
    }
  }

  return array;
}

// Time and Space Complexity Analysis //

// Time Complexity: O(n^2)

// Picture the worst case scenario where our input array is completely unsorted. 
// Let's say it's sorted in fully decreasing order, but our goal is to sort it 
// in increasing order:

// - n is the length of the inut array
// - The inner for loop along contributes O(n) in isolation, this is plain to see
// - The outer while loop contributes O(n) in isolation because a single iteration 
//   of the while loop will bring one element to it's final resting position. 
//   In other words, we keep running the while loop until the array is fully sorted. 
//   To fully sort the array we will need to bring all n elements into their final 
//   resting positions.
// - Those two loops are nested so our total time complexity is O(n * n) = O(n2).

// It's worst mentioning that the best case scenario is when the input array is 
// already fully sorted. This will cause our for loop to conduct a single pass 
// without performing any swap, so the while loop will not trigger further iterations. 
// This means best case time complexity is O(n) for bubble sort. This best case linear 
// time is probably the only advantage of bubble sort. We are mainly interested in \
// the worst case as engineers, so overall we are not impressed.

// Space Complexity: O(1)

// Bubble Sort is a constant space, O(1), algorithm. The amount of memory consumed 
// by the algorithm does not increase relative to the size of the input array. 
// We use the same amount of memory and create the same amount of letiables regardless 
// of the size of our input, making this algorithm quite space efficient. The space 
// efficiency mostly comes from the fact that we mutate the input array, in-place.
