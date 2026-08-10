.class public Lcom/alibaba/sdk/android/logger/b/b;
.super Ljava/lang/Object;


# static fields
.field private static final a:Lcom/alibaba/sdk/android/logger/LogLevel;


# instance fields
.field private b:Z

.field private c:Lcom/alibaba/sdk/android/logger/LogLevel;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/logger/LogLevel;->WARN:Lcom/alibaba/sdk/android/logger/LogLevel;

    sput-object v0, Lcom/alibaba/sdk/android/logger/b/b;->a:Lcom/alibaba/sdk/android/logger/LogLevel;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/logger/b/b;->b:Z

    sget-object v0, Lcom/alibaba/sdk/android/logger/b/b;->a:Lcom/alibaba/sdk/android/logger/LogLevel;

    iput-object v0, p0, Lcom/alibaba/sdk/android/logger/b/b;->c:Lcom/alibaba/sdk/android/logger/LogLevel;

    return-void
.end method


# virtual methods
.method public a(Lcom/alibaba/sdk/android/logger/LogLevel;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/logger/b/b;->c:Lcom/alibaba/sdk/android/logger/LogLevel;

    return-void
.end method

.method public a(Z)V
    .locals 0

    iput-boolean p1, p0, Lcom/alibaba/sdk/android/logger/b/b;->b:Z

    return-void
.end method

.method public b(Lcom/alibaba/sdk/android/logger/LogLevel;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/logger/b/b;->b:Z

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/logger/LogLevel;->ordinal()I

    move-result p1

    iget-object v0, p0, Lcom/alibaba/sdk/android/logger/b/b;->c:Lcom/alibaba/sdk/android/logger/LogLevel;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/logger/LogLevel;->ordinal()I

    move-result v0

    if-lt p1, v0, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    return p1
.end method
