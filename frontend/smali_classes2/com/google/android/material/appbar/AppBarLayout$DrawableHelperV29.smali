.class Lcom/google/android/material/appbar/AppBarLayout$DrawableHelperV29;
.super Ljava/lang/Object;
.source "AppBarLayout.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/material/appbar/AppBarLayout;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "DrawableHelperV29"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 2573
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/graphics/drawable/Drawable;)Landroid/content/res/ColorStateList;
    .locals 0

    .line 2573
    invoke-static {p0}, Lcom/google/android/material/appbar/AppBarLayout$DrawableHelperV29;->maybeGetBackgroundCSL(Landroid/graphics/drawable/Drawable;)Landroid/content/res/ColorStateList;

    move-result-object p0

    return-object p0
.end method

.method private static maybeGetBackgroundCSL(Landroid/graphics/drawable/Drawable;)Landroid/content/res/ColorStateList;
    .locals 1

    .line 2577
    instance-of v0, p0, Landroid/graphics/drawable/ColorStateListDrawable;

    if-eqz v0, :cond_0

    .line 2578
    check-cast p0, Landroid/graphics/drawable/ColorStateListDrawable;

    invoke-virtual {p0}, Landroid/graphics/drawable/ColorStateListDrawable;->getColorStateList()Landroid/content/res/ColorStateList;

    move-result-object p0

    return-object p0

    :cond_0
    const/4 p0, 0x0

    return-object p0
.end method
