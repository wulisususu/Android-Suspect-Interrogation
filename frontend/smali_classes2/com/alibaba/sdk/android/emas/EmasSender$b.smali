.class Lcom/alibaba/sdk/android/emas/EmasSender$b;
.super Ljava/lang/Object;
.source "EmasSender.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/emas/EmasSender;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/emas/EmasSender;

.field private final a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final b:J

.field private final d:I

.field private final d:Ljava/lang/String;

.field private final e:Ljava/lang/String;

.field private final f:Ljava/lang/String;

.field private final g:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/alibaba/sdk/android/emas/EmasSender;JLjava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/lang/String;",
            "I",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    .line 137
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p2, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->b:J

    iput-object p4, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->d:Ljava/lang/String;

    iput p5, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->d:I

    iput-object p6, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->e:Ljava/lang/String;

    iput-object p7, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->f:Ljava/lang/String;

    iput-object p8, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->g:Ljava/lang/String;

    iput-object p9, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->a:Ljava/util/Map;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 11

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    .line 150
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/EmasSender;->access$2300(Lcom/alibaba/sdk/android/emas/EmasSender;)Lcom/alibaba/sdk/android/emas/j;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/emas/j;->a()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v1

    iget-object v0, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    .line 151
    invoke-static {v0}, Lcom/alibaba/sdk/android/emas/EmasSender;->access$2300(Lcom/alibaba/sdk/android/emas/EmasSender;)Lcom/alibaba/sdk/android/emas/j;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/emas/j;->a()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v0

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/tbrest/SendService;->getAppKey()Ljava/lang/String;

    move-result-object v2

    iget-wide v3, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->b:J

    iget-object v5, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->d:Ljava/lang/String;

    iget v6, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->d:I

    iget-object v7, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->e:Ljava/lang/String;

    iget-object v8, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->f:Ljava/lang/String;

    iget-object v9, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->g:Ljava/lang/String;

    iget-object v10, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->a:Ljava/util/Map;

    .line 150
    invoke-static/range {v1 .. v10}, Lcom/alibaba/sdk/android/tbrest/rest/d;->a(Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0

    .line 154
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "UTF-8"

    .line 155
    invoke-static {v1}, Ljava/nio/charset/Charset;->forName(Ljava/lang/String;)Ljava/nio/charset/Charset;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    array-length v1, v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->a:Lcom/alibaba/sdk/android/emas/EmasSender;

    .line 157
    invoke-static {v2}, Lcom/alibaba/sdk/android/emas/EmasSender;->access$2400(Lcom/alibaba/sdk/android/emas/EmasSender;)I

    move-result v2

    if-gt v1, v2, :cond_0

    .line 158
    new-instance v1, Lcom/alibaba/sdk/android/emas/g;

    iget v2, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->d:I

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    iget-wide v3, p0, Lcom/alibaba/sdk/android/emas/EmasSender$b;->b:J

    invoke-direct {v1, v2, v0, v3, v4}, Lcom/alibaba/sdk/android/emas/g;-><init>(Ljava/lang/String;Ljava/lang/String;J)V

    .line 161
    invoke-static {}, Lcom/alibaba/sdk/android/emas/EmasSender;->access$2500()Landroid/os/Handler;

    move-result-object v0

    const/4 v2, 0x1

    invoke-virtual {v0, v2, v1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Message;->sendToTarget()V

    goto :goto_0

    .line 163
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "EmasSender send failed. build data is exceed limit. current length: "

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    const-string v0, "EmasSender send failed. build data is null."

    .line 167
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->d(Ljava/lang/String;)V

    :goto_0
    return-void
.end method
