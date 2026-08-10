.class public Lplugins/NoTrouble/NoTrouble;
.super Ljava/lang/Object;
.source "NoTrouble.java"


# instance fields
.field private activity:Landroidx/appcompat/app/AppCompatActivity;


# direct methods
.method public constructor <init>(Landroidx/appcompat/app/AppCompatActivity;)V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lplugins/NoTrouble/NoTrouble;->activity:Landroidx/appcompat/app/AppCompatActivity;

    return-void
.end method

.method private fromRotationToOrientationType(I)Ljava/lang/String;
    .locals 1

    const/4 v0, 0x1

    if-eq p1, v0, :cond_2

    const/4 v0, 0x2

    if-eq p1, v0, :cond_1

    const/4 v0, 0x3

    if-eq p1, v0, :cond_0

    const-string p1, "portrait-primary"

    return-object p1

    :cond_0
    const-string p1, "landscape-secondary"

    return-object p1

    :cond_1
    const-string p1, "portrait-secondary"

    return-object p1

    :cond_2
    const-string p1, "landscape-primary"

    return-object p1
.end method


# virtual methods
.method public getCurrentOrientationType()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lplugins/NoTrouble/NoTrouble;->activity:Landroidx/appcompat/app/AppCompatActivity;

    .line 16
    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v0

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Display;->getRotation()I

    move-result v0

    .line 17
    invoke-direct {p0, v0}, Lplugins/NoTrouble/NoTrouble;->fromRotationToOrientationType(I)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
