.class public Lcom/ali/alihadeviceevaluator/opengl/AliHAOpenGL;
.super Ljava/lang/Object;
.source "AliHAOpenGL.java"


# instance fields
.field public mOpenGLVersion:F

.field public mScore:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/ali/alihadeviceevaluator/opengl/AliHAOpenGL;->mOpenGLVersion:F

    return-void
.end method


# virtual methods
.method public generateOpenGLVersion(Landroid/content/Context;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "context"
        }
    .end annotation

    iget v0, p0, Lcom/ali/alihadeviceevaluator/opengl/AliHAOpenGL;->mOpenGLVersion:F

    const/4 v1, 0x0

    cmpl-float v0, v0, v1

    if-eqz v0, :cond_0

    return-void

    :cond_0
    if-nez p1, :cond_1

    return-void

    :cond_1
    const/high16 v0, 0x40000000    # 2.0f

    :try_start_0
    const-string v1, "activity"

    .line 16
    invoke-virtual {p1, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/app/ActivityManager;

    .line 17
    invoke-virtual {p1}, Landroid/app/ActivityManager;->getDeviceConfigurationInfo()Landroid/content/pm/ConfigurationInfo;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/pm/ConfigurationInfo;->getGlEsVersion()Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_2

    .line 19
    invoke-static {p1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move v0, p1

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 22
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    :goto_0
    iput v0, p0, Lcom/ali/alihadeviceevaluator/opengl/AliHAOpenGL;->mOpenGLVersion:F

    .line 25
    invoke-virtual {p0, v0}, Lcom/ali/alihadeviceevaluator/opengl/AliHAOpenGL;->getScore(F)I

    move-result p1

    iput p1, p0, Lcom/ali/alihadeviceevaluator/opengl/AliHAOpenGL;->mScore:I

    return-void
.end method

.method public getScore(F)I
    .locals 5
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "openGLVersion"
        }
    .end annotation

    float-to-double v0, p1

    const-wide/high16 v2, 0x4010000000000000L    # 4.0

    cmpl-double p1, v0, v2

    if-lez p1, :cond_0

    const/16 p1, 0xa

    goto :goto_0

    :cond_0
    if-ltz p1, :cond_1

    const/16 p1, 0x9

    goto :goto_0

    :cond_1
    const-wide v2, 0x400999999999999aL    # 3.2

    cmpl-double p1, v0, v2

    const/16 v2, 0x8

    if-ltz p1, :cond_3

    :cond_2
    move p1, v2

    goto :goto_0

    :cond_3
    const-wide v3, 0x4008cccccccccccdL    # 3.1

    cmpl-double p1, v0, v3

    if-ltz p1, :cond_4

    const/4 p1, 0x7

    goto :goto_0

    :cond_4
    const-wide/high16 v3, 0x4008000000000000L    # 3.0

    cmpl-double p1, v0, v3

    if-ltz p1, :cond_5

    const/4 p1, 0x6

    goto :goto_0

    :cond_5
    const-wide/high16 v3, 0x4000000000000000L    # 2.0

    cmpl-double p1, v0, v3

    if-ltz p1, :cond_2

    const/4 p1, 0x3

    :goto_0
    return p1
.end method
