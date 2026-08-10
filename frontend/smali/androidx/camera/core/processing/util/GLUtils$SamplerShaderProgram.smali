.class public Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;
.super Landroidx/camera/core/processing/util/GLUtils$Program2D;
.source "GLUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/core/processing/util/GLUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "SamplerShaderProgram"
.end annotation


# instance fields
.field private mSamplerLoc:I

.field private mTexCoordLoc:I

.field private mTexMatrixLoc:I


# direct methods
.method public constructor <init>(Landroidx/camera/core/DynamicRange;Landroidx/camera/core/processing/ShaderProvider;)V
    .locals 0

    .line 347
    invoke-virtual {p1}, Landroidx/camera/core/DynamicRange;->is10BitHdr()Z

    move-result p1

    if-eqz p1, :cond_0

    sget-object p1, Landroidx/camera/core/processing/util/GLUtils;->HDR_VERTEX_SHADER:Ljava/lang/String;

    goto :goto_0

    :cond_0
    sget-object p1, Landroidx/camera/core/processing/util/GLUtils;->DEFAULT_VERTEX_SHADER:Ljava/lang/String;

    .line 348
    :goto_0
    invoke-static {p2}, Landroidx/camera/core/processing/util/GLUtils;->access$000(Landroidx/camera/core/processing/ShaderProvider;)Ljava/lang/String;

    move-result-object p2

    .line 347
    invoke-direct {p0, p1, p2}, Landroidx/camera/core/processing/util/GLUtils$Program2D;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    const/4 p1, -0x1

    iput p1, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mSamplerLoc:I

    iput p1, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mTexMatrixLoc:I

    iput p1, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mTexCoordLoc:I

    .line 350
    invoke-direct {p0}, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->loadLocations()V

    return-void
.end method

.method public constructor <init>(Landroidx/camera/core/DynamicRange;Landroidx/camera/core/processing/util/GLUtils$InputFormat;)V
    .locals 0

    .line 341
    invoke-static {p1, p2}, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->resolveDefaultShaderProvider(Landroidx/camera/core/DynamicRange;Landroidx/camera/core/processing/util/GLUtils$InputFormat;)Landroidx/camera/core/processing/ShaderProvider;

    move-result-object p2

    invoke-direct {p0, p1, p2}, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;-><init>(Landroidx/camera/core/DynamicRange;Landroidx/camera/core/processing/ShaderProvider;)V

    return-void
.end method

.method private loadLocations()V
    .locals 2

    .line 379
    invoke-static {p0}, Landroidx/camera/core/processing/util/GLUtils$Program2D;->access$100(Landroidx/camera/core/processing/util/GLUtils$Program2D;)V

    .line 380
    iget v0, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mProgramHandle:I

    const-string/jumbo v1, "sTexture"

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mSamplerLoc:I

    .line 381
    invoke-static {v0, v1}, Landroidx/camera/core/processing/util/GLUtils;->checkLocationOrThrow(ILjava/lang/String;)V

    .line 382
    iget v0, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mProgramHandle:I

    const-string v1, "aTextureCoord"

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glGetAttribLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mTexCoordLoc:I

    .line 383
    invoke-static {v0, v1}, Landroidx/camera/core/processing/util/GLUtils;->checkLocationOrThrow(ILjava/lang/String;)V

    .line 384
    iget v0, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mProgramHandle:I

    const-string/jumbo v1, "uTexMatrix"

    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glGetUniformLocation(ILjava/lang/String;)I

    move-result v0

    iput v0, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mTexMatrixLoc:I

    .line 385
    invoke-static {v0, v1}, Landroidx/camera/core/processing/util/GLUtils;->checkLocationOrThrow(ILjava/lang/String;)V

    return-void
.end method

.method private static resolveDefaultShaderProvider(Landroidx/camera/core/DynamicRange;Landroidx/camera/core/processing/util/GLUtils$InputFormat;)Landroidx/camera/core/processing/ShaderProvider;
    .locals 2

    .line 391
    invoke-virtual {p0}, Landroidx/camera/core/DynamicRange;->is10BitHdr()Z

    move-result p0

    if-eqz p0, :cond_2

    .line 392
    sget-object p0, Landroidx/camera/core/processing/util/GLUtils$InputFormat;->UNKNOWN:Landroidx/camera/core/processing/util/GLUtils$InputFormat;

    if-eq p1, p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "No default sampler shader available for"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p0, v0}, Landroidx/core/util/Preconditions;->checkArgument(ZLjava/lang/Object;)V

    .line 394
    sget-object p0, Landroidx/camera/core/processing/util/GLUtils$InputFormat;->YUV:Landroidx/camera/core/processing/util/GLUtils$InputFormat;

    if-ne p1, p0, :cond_1

    .line 395
    invoke-static {}, Landroidx/camera/core/processing/util/GLUtils;->access$200()Landroidx/camera/core/processing/ShaderProvider;

    move-result-object p0

    return-object p0

    .line 397
    :cond_1
    invoke-static {}, Landroidx/camera/core/processing/util/GLUtils;->access$300()Landroidx/camera/core/processing/ShaderProvider;

    move-result-object p0

    return-object p0

    .line 399
    :cond_2
    invoke-static {}, Landroidx/camera/core/processing/util/GLUtils;->access$400()Landroidx/camera/core/processing/ShaderProvider;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public updateTextureMatrix([F)V
    .locals 3

    iget v0, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mTexMatrixLoc:I

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 373
    invoke-static {v0, v1, v2, p1, v2}, Landroid/opengl/GLES20;->glUniformMatrix4fv(IIZ[FI)V

    const-string p1, "glUniformMatrix4fv"

    .line 375
    invoke-static {p1}, Landroidx/camera/core/processing/util/GLUtils;->checkGlErrorOrThrow(Ljava/lang/String;)V

    return-void
.end method

.method public use()V
    .locals 7

    .line 355
    invoke-super {p0}, Landroidx/camera/core/processing/util/GLUtils$Program2D;->use()V

    iget v0, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mSamplerLoc:I

    const/4 v1, 0x0

    .line 357
    invoke-static {v0, v1}, Landroid/opengl/GLES20;->glUniform1i(II)V

    iget v0, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mTexCoordLoc:I

    .line 360
    invoke-static {v0}, Landroid/opengl/GLES20;->glEnableVertexAttribArray(I)V

    const-string v0, "glEnableVertexAttribArray"

    .line 361
    invoke-static {v0}, Landroidx/camera/core/processing/util/GLUtils;->checkGlErrorOrThrow(Ljava/lang/String;)V

    const/4 v2, 0x2

    const/4 v5, 0x0

    iget v1, p0, Landroidx/camera/core/processing/util/GLUtils$SamplerShaderProgram;->mTexCoordLoc:I

    const/16 v3, 0x1406

    const/4 v4, 0x0

    .line 366
    sget-object v6, Landroidx/camera/core/processing/util/GLUtils;->TEX_BUF:Ljava/nio/FloatBuffer;

    invoke-static/range {v1 .. v6}, Landroid/opengl/GLES20;->glVertexAttribPointer(IIIZILjava/nio/Buffer;)V

    const-string v0, "glVertexAttribPointer"

    .line 368
    invoke-static {v0}, Landroidx/camera/core/processing/util/GLUtils;->checkGlErrorOrThrow(Ljava/lang/String;)V

    return-void
.end method
