export const keyHandler = (options = {}) => e => {
    if(typeof options !== 'object' || options === null) {
        return;
    }

    const {
        fn = () => {},
        keys = ['Enter', ' '],
        stopProp = true,
        prevDef = true
    } = options;

    if (keys.indexOf(e.key) !== -1) {
        stopProp && e.stopPropagation();
        prevDef && e.preventDefault();
        return fn();
    }
}
