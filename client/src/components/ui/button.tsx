"use client";

import React from "react";

type ButtonVariant = "primary" | "secondary" | "blank";

interface ButtonProps {
  variant?: ButtonVariant;
  onClick?: () => void;
  children: React.ReactNode;
  className?: string;
}

const Button: React.FC<ButtonProps> = ({
  variant = "primary",
  onClick,
  children,
  className,
}) => {
  const baseStyles =
    "min-w-40 w-fit px-4 h-10 text-[18px] flex items-center justify-center rounded-lg transition-all duration-100";

  const variantStyles = {
    primary:
      "bg-orange-600 text-white hover:bg-orange-500 focus:ring-2 focus:ring-orange-300",
    secondary:
      "bg-indigo-900 text-white hover:bg-indigo-800 focus:ring-2 focus:ring-purple-300",
    blank:
      "border border-white text-white hover:bg-white hover:text-black focus:ring-2 focus:ring-gray-300",
  };

  const buttonClass = `${baseStyles} ${variantStyles[variant]}`;

  return (
    <button className={`${buttonClass} ${className}`} onClick={onClick}>
      {children}
    </button>
  );
};

export default Button;
