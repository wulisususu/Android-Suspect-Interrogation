.class final Lcom/aliyun/emas/apm/crash/internal/model/g$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/g;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;

.field private g:I

.field private h:I

.field private i:J

.field private j:J

.field private k:Z

.field private l:I

.field private m:Ljava/lang/String;

.field private n:Ljava/lang/String;

.field private o:Z

.field private p:B


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;
    .locals 24

    move-object/from16 v0, p0

    iget-byte v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    const/16 v2, 0x7f

    if-ne v1, v2, :cond_1

    iget-object v4, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->a:Ljava/lang/String;

    if-eqz v4, :cond_1

    iget-object v5, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->b:Ljava/lang/String;

    if-eqz v5, :cond_1

    iget-object v6, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->c:Ljava/lang/String;

    if-eqz v6, :cond_1

    iget-object v7, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->d:Ljava/lang/String;

    if-eqz v7, :cond_1

    iget-object v8, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->e:Ljava/lang/String;

    if-eqz v8, :cond_1

    iget-object v9, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->f:Ljava/lang/String;

    if-eqz v9, :cond_1

    iget-object v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->m:Ljava/lang/String;

    if-eqz v1, :cond_1

    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->n:Ljava/lang/String;

    if-nez v2, :cond_0

    goto :goto_0

    .line 58
    :cond_0
    new-instance v22, Lcom/aliyun/emas/apm/crash/internal/model/g;

    move-object/from16 v3, v22

    iget v10, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->g:I

    iget v11, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->h:I

    iget-wide v12, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->i:J

    iget-wide v14, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->j:J

    move-object/from16 v23, v3

    iget-boolean v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->k:Z

    move/from16 v16, v3

    iget v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->l:I

    move/from16 v17, v3

    iget-boolean v3, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->o:Z

    move/from16 v20, v3

    const/16 v21, 0x0

    move-object/from16 v18, v1

    move-object/from16 v19, v2

    move-object/from16 v3, v23

    invoke-direct/range {v3 .. v21}, Lcom/aliyun/emas/apm/crash/internal/model/g;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IIJJZILjava/lang/String;Ljava/lang/String;ZLcom/aliyun/emas/apm/crash/internal/model/g$a;)V

    return-object v22

    .line 59
    :cond_1
    :goto_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->a:Ljava/lang/String;

    if-nez v2, :cond_2

    const-string v2, " brand"

    .line 61
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->b:Ljava/lang/String;

    if-nez v2, :cond_3

    const-string v2, " model"

    .line 64
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_3
    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->c:Ljava/lang/String;

    if-nez v2, :cond_4

    const-string v2, " os"

    .line 67
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_4
    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->d:Ljava/lang/String;

    if-nez v2, :cond_5

    const-string v2, " version"

    .line 70
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_5
    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->e:Ljava/lang/String;

    if-nez v2, :cond_6

    const-string v2, " language"

    .line 73
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_6
    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->f:Ljava/lang/String;

    if-nez v2, :cond_7

    const-string v2, " resolution"

    .line 76
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_7
    iget-byte v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    and-int/lit8 v2, v2, 0x1

    if-nez v2, :cond_8

    const-string v2, " arch"

    .line 79
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_8
    iget-byte v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    and-int/lit8 v2, v2, 0x2

    if-nez v2, :cond_9

    const-string v2, " cores"

    .line 82
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_9
    iget-byte v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    and-int/lit8 v2, v2, 0x4

    if-nez v2, :cond_a

    const-string v2, " ram"

    .line 85
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_a
    iget-byte v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    and-int/lit8 v2, v2, 0x8

    if-nez v2, :cond_b

    const-string v2, " diskSpace"

    .line 88
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_b
    iget-byte v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    and-int/lit8 v2, v2, 0x10

    if-nez v2, :cond_c

    const-string v2, " simulator"

    .line 91
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_c
    iget-byte v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    and-int/lit8 v2, v2, 0x20

    if-nez v2, :cond_d

    const-string v2, " state"

    .line 94
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_d
    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->m:Ljava/lang/String;

    if-nez v2, :cond_e

    const-string v2, " manufacturer"

    .line 97
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_e
    iget-object v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->n:Ljava/lang/String;

    if-nez v2, :cond_f

    const-string v2, " modelClass"

    .line 100
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_f
    iget-byte v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    and-int/lit8 v2, v2, 0x40

    if-nez v2, :cond_10

    const-string v2, " jailbroken"

    .line 103
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 105
    :cond_10
    new-instance v2, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Missing required properties:"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public setArch(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->g:I

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    or-int/lit8 p1, p1, 0x1

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    return-object p0
.end method

.method public setBrand(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->a:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null brand"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setCores(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->h:I

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    or-int/lit8 p1, p1, 0x2

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    return-object p0
.end method

.method public setDiskSpace(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 0

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->j:J

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    or-int/lit8 p1, p1, 0x8

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    return-object p0
.end method

.method public setJailbroken(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->o:Z

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    or-int/lit8 p1, p1, 0x40

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    return-object p0
.end method

.method public setLanguage(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->e:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null language"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setManufacturer(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->m:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null manufacturer"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setModel(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->b:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null model"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setModelClass(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->n:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null modelClass"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setOs(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->c:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null os"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setRam(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 0

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->i:J

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    or-int/lit8 p1, p1, 0x4

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    return-object p0
.end method

.method public setResolution(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->f:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null resolution"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public setSimulator(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->k:Z

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    or-int/lit8 p1, p1, 0x10

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    return-object p0
.end method

.method public setState(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->l:I

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    or-int/lit8 p1, p1, 0x20

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->p:B

    return-object p0
.end method

.method public setVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/g$b;->d:Ljava/lang/String;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null version"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
