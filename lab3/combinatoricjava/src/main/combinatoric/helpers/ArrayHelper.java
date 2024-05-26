package main.combinatoric.helpers;

public class ArrayHelper {

    public static boolean inArray(Integer[] array, Integer element) {
        BaseArrayHelper<Integer> helper = new BaseArrayHelper<Integer>(array);
        return helper.inArray(element);
    }

    public static String[] removeElement(String[] array, String value) {
        BaseArrayHelper<String> helper = new BaseArrayHelper<String>(array);
        return helper.removeElement(value);
    }

    public static Integer[] removeElement(Integer[] array, Integer value) {
        BaseArrayHelper<Integer> helper = new BaseArrayHelper<Integer>(array);
        return helper.removeElement(value);
    }

    /**
     * Получить разницу двух массивов
     * @param arr1
     * @param arr2
     * @return
     */
    public static Integer[] getDifference(Integer[] arr1, Integer[] arr2) {
        int count = 0;
        boolean found;

        // Подсчет количества элементов в разнице массивов
        for (int num1 : arr1) {
            found = false;
            for (int num2 : arr2) {
                if (num1 == num2) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                count++;
            }
        }

        // Создание массива для разницы
        Integer[] difference = new Integer[count];
        int index = 0;

        // Заполнение массива разницы
        for (int num1 : arr1) {
            found = false;
            for (int num2 : arr2) {
                if (num1 == num2) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                difference[index++] = num1;
            }
        }

        return difference;
    }

}
