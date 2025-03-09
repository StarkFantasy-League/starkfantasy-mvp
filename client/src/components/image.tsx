import React from 'react';

interface ImageProps {
    src: string;
    alt: string;
    className?: string;
    width?: number;
    height?: number;
}

const Image: React.FC<ImageProps> = ({ src, alt, className, width, height }) => {
    const rootDirectory = '../public';

    return (
        <img
            src={`${rootDirectory}/${src}`}
            alt={alt}
            className={`${className} w-[${width}px] h-[${height}px]`}
        />
    );
};

export default Image;