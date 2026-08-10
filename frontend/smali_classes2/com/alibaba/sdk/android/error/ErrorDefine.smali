.class public Lcom/alibaba/sdk/android/error/ErrorDefine;
.super Ljava/lang/Object;


# static fields
.field public static final TYPE_ANDROID:Ljava/lang/String; = "ANDROID"

.field public static final TYPE_SDK:Ljava/lang/String; = "SDK"

.field public static final TYPE_SERVER:Ljava/lang/String; = "SERVER"


# instance fields
.field private codeGenerator:Lcom/alibaba/sdk/android/error/CodeGenerator;

.field private label:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->label:Ljava/lang/String;

    new-instance p1, Lcom/alibaba/sdk/android/error/CodeGenerator;

    invoke-direct {p1}, Lcom/alibaba/sdk/android/error/CodeGenerator;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->codeGenerator:Lcom/alibaba/sdk/android/error/CodeGenerator;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/alibaba/sdk/android/error/CodeGenerator;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->label:Ljava/lang/String;

    iput-object p2, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->codeGenerator:Lcom/alibaba/sdk/android/error/CodeGenerator;

    return-void
.end method

.method private static formCode(Lcom/alibaba/sdk/android/error/CodeGenerator;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/Code;
    .locals 1

    invoke-virtual {p0, p1, p2, p3}, Lcom/alibaba/sdk/android/error/CodeGenerator;->generateCodeStr(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, p1, p2, p3}, Lcom/alibaba/sdk/android/error/CodeGenerator;->generateCodeInt(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object p0

    new-instance p1, Lcom/alibaba/sdk/android/error/Code;

    invoke-direct {p1, v0, p0}, Lcom/alibaba/sdk/android/error/Code;-><init>(Ljava/lang/String;Ljava/lang/Integer;)V

    return-object p1
.end method


# virtual methods
.method public defineAndroidError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->codeGenerator:Lcom/alibaba/sdk/android/error/CodeGenerator;

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->label:Ljava/lang/String;

    const-string v2, "ANDROID"

    invoke-static {v0, v1, v2, p1}, Lcom/alibaba/sdk/android/error/ErrorDefine;->formCode(Lcom/alibaba/sdk/android/error/CodeGenerator;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/Code;

    move-result-object p1

    invoke-static {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->builder(Lcom/alibaba/sdk/android/error/Code;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    return-object p1
.end method

.method public defineError(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->codeGenerator:Lcom/alibaba/sdk/android/error/CodeGenerator;

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->label:Ljava/lang/String;

    invoke-static {v0, v1, p1, p2}, Lcom/alibaba/sdk/android/error/ErrorDefine;->formCode(Lcom/alibaba/sdk/android/error/CodeGenerator;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/Code;

    move-result-object p1

    invoke-static {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->builder(Lcom/alibaba/sdk/android/error/Code;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    return-object p1
.end method

.method public defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->codeGenerator:Lcom/alibaba/sdk/android/error/CodeGenerator;

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->label:Ljava/lang/String;

    const-string v2, "SDK"

    invoke-static {v0, v1, v2, p1}, Lcom/alibaba/sdk/android/error/ErrorDefine;->formCode(Lcom/alibaba/sdk/android/error/CodeGenerator;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/Code;

    move-result-object p1

    invoke-static {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->builder(Lcom/alibaba/sdk/android/error/Code;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    return-object p1
.end method

.method public defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->codeGenerator:Lcom/alibaba/sdk/android/error/CodeGenerator;

    iget-object v1, p0, Lcom/alibaba/sdk/android/error/ErrorDefine;->label:Ljava/lang/String;

    const-string v2, "SERVER"

    invoke-static {v0, v1, v2, p1}, Lcom/alibaba/sdk/android/error/ErrorDefine;->formCode(Lcom/alibaba/sdk/android/error/CodeGenerator;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/Code;

    move-result-object p1

    invoke-static {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->builder(Lcom/alibaba/sdk/android/error/Code;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    return-object p1
.end method
