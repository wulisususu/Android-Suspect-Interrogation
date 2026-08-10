.class public Lcom/alibaba/sdk/android/crashdefend/a/b;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Cloneable;


# instance fields
.field public a:Ljava/lang/String;

.field public b:Ljava/lang/String;

.field public c:I

.field public d:I

.field public e:I

.field public f:J

.field public g:J

.field public h:I

.field public i:J

.field public volatile j:Z

.field public k:Lcom/alibaba/sdk/android/crashdefend/CrashDefendCallback;


# direct methods
.method public constructor <init>()V
    .locals 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/alibaba/sdk/android/crashdefend/a/b;->h:I

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/alibaba/sdk/android/crashdefend/a/b;->i:J

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/crashdefend/a/b;->j:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/sdk/android/crashdefend/a/b;->k:Lcom/alibaba/sdk/android/crashdefend/CrashDefendCallback;

    return-void
.end method


# virtual methods
.method public clone()Ljava/lang/Object;
    .locals 3

    :try_start_0
    invoke-super {p0}, Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/alibaba/sdk/android/crashdefend/a/b;
    :try_end_0
    .catch Ljava/lang/CloneNotSupportedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "CrashSDK"

    const-string v2, "clone fail: "

    invoke-static {v1, v2, v0}, Lcom/alibaba/sdk/android/crashdefend/c/b;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Exception;)V

    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method
