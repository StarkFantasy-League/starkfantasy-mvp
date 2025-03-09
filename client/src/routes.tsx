/**
 * DON'T MODIFY THIS DOCUMENT
 * The present code is the configuration in order to use file system navigation
 * Special notes:
 *  - Don't use a `pages` folder to specify the visual routes
 *  - Use screaming architecture, main folders must represent modules, not thecnical divisions
 *  - Use `page.tsx` to creater the main page of a module
 *  - Use `layout.tsx` for the definition of special layouts in modules
 */


import { ComponentType, lazy } from "react";

type LayoutModule = {
  default: ComponentType<any>;
};
// Define the type for the page module
type PageModule = {
  default: ComponentType<any>;
};

// Escanear todos los archivos en "modules"
const pages = import.meta.glob<PageModule>("./app/**/page.tsx");
const layouts = import.meta.glob<LayoutModule>("./app/**/layout.tsx");

interface Route {
  path: string;
  element: JSX.Element | null;
  children: Record<string, Route>;
}

const buildRoutes = (paths: string[], base = ""): Route[] => {
  const routeMap: Record<string, Route> = {};

  paths.forEach((path) => {
    const relativePath = path.replace("./app/", "").replace("/page.tsx", "");
    const segments = relativePath.split("/");

    let current: Record<string, Route> = routeMap;
    let accumulatedPath = base;

    segments.forEach((segment, index) => {
      accumulatedPath += `/${segment}`;

      if (!current[segment]) {
        current[segment] = {
          path: accumulatedPath,
          element: null,
          children: {},
        };
      }

      if (index === segments.length - 1) {
        const Layout = layouts[`./app/${relativePath}/layout.tsx`]
          ? lazy(layouts[`./app/${relativePath}/layout.tsx`])
          : null;
        const Page = lazy(pages[path]);

        current[segment].element = Layout ? (
          <Layout>
            <Page />
          </Layout>
        ) : (
          <Page />
        );
      }

      current = current[segment].children;
    });
  });

  return Object.values(routeMap);
};

// Crear rutas jerárquicas
const routes = buildRoutes(Object.keys(pages));

// Check if there is a root route ("/"), if not, add it
const hasRootRoute = routes.some((route) => route.path === "/");

if (!hasRootRoute) {
  const RootPage = lazy(pages["./app/page.tsx"]);
  routes.unshift({
    path: "/",
    element: <RootPage />,
    children: {},
  });
}

export default routes;
